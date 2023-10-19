from flask import Flask, request, jsonify
import pandas as pd
import numpy as np
import nltk
from nltk.stem.snowball import SnowballStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
"""
dfa=pd.read_csv("movies-1-1.csv")
dfe=pd.read_csv("movies-1-2.csv")
dfb=pd.read_csv("movies-2.csv")
dfc=pd.read_csv("movies-3.csv")
dfd=pd.read_csv("movies-4.csv")
"""
df=pd.read_csv('movies.csv')
#df=pd.concat([dfa, dfe, dfb, dfc, dfd], axis=0)
df.drop_duplicates(inplace=True)
#removing subsets with same title and release date
df.drop_duplicates(subset=['title','release_date'], inplace=True)
df1 = df[df.vote_count >= 20].reset_index()
# replacing na with ''
df1.fillna('', inplace=True)
# finding index with '' genres and overview
index = df1[(df1['genres']=="") & (df1['overview']=="")].index.values
df1.drop(index, inplace=True)
df2=df1['genres']
df3=df1['keywords']
df4=df1['credits']
df1['genres'] = df2.apply(lambda x: ' '.join(x.split('-')))
#df1['keywords'] = df3.apply(lambda x: ' '.join(x.split('-')))
#df1['credits'] = df4.apply(lambda x: ' '.join(x.replace(' ', '').split('-')[:5]))
#print(df['genres'])
df1['tags']=df1['overview'] +' '+ df1['genres'] +' '+ df1['keywords'] +' '+ df1['original_language']+' '+ df1['credits']+' '+df1['poster_path']
df1['tags'] = df1['tags'].str.replace('[^\w\s]','')
# Tfidf basically finds similarity between two texts
tfidf = TfidfVectorizer(stop_words='english')
tfidf_matrix = tfidf.fit_transform(df1['tags'])
app=Flask(__name__)
@app.route('/api',methods=['GET'])
def help():
  d={}
  title=str(request.args['query'])
  idx = df1.index[df1['title'] == title][0]
  sim_scores = list(enumerate(cosine_similarity(tfidf_matrix,tfidf_matrix[idx])))
  sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
  sim_scores = sim_scores[0:8]
  movie_indices = [i[0] for i in sim_scores]
  result = df1.iloc[movie_indices].values
  arr=np.ravel(result[:,2:3])
  brr=np.ravel(result[:,18:19])
  crr=np.ravel(result[:,5:6])
  drr=np.ravel(result[:,16:17])
  for i in range(8):
      array=[brr[i],crr[i],drr[i]]
      d[arr[i]]=array
  return d
if(__name__=="__main__"):
  app.run()