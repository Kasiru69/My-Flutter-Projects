import 'dart:convert';

import 'package:flutter/material.dart';

import 'function.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController=TextEditingController();
  List<String> name=[];
  List<String> img=[];
  List<String> cast=[];
  String _str=" ",_s=" ";
  var data,_decode=new Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        /*decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/Images/backimg.jpg"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _textController,
                onChanged: (value){ _str=value.toString(); },
                style: TextStyle(color: Colors.red),
                  decoration: InputDecoration(
                      hintText: 'Enter a movie name',
                      hintStyle: TextStyle(
                          color: Colors.red
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                        borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    suffixIcon: IconButton(icon: Icon(Icons.search),color: Colors.red, onPressed: () async{
                      name=[];
                      img=[];
                      cast=[];
                      String _url="http://127.0.0.1:5000/api?query="+_str;
                      data=await fetchdata(_url);
                      _decode=jsonDecode(data);
                      _textController.clear();
                      print(_decode[_str][0]);
                      setState(() {
                        for(var it in _decode.keys) {
                          if(it==_str) { _s=_decode[it][2]; continue; }
                          name.add(it);
                          img.add(_decode[it][0]);
                        }
                        print(_s);
                      });
                    },)
                  )
              ),
              SizedBox(height: 20,),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: (_decode.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+_decode[_str][0]):Image.network("https://image.tmdb.org/t/p/w500"+"/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"),
                    ),
                    Container(
                      height: 300,
                      width: (MediaQuery.of(context).size.width)/4,
                      child: Text((_decode.length!=0)?_str+"\n\n"+_decode[_str][1]:"Avatar\n\nIn the 22nd century a paraplegic Marine is dispatched to the moon Pandora on a unique mission but becomes torn between following orders and protecting an alien civilization.",style: TextStyle(color: Colors.red),),
                    ),
                    Container(
                      height: 300,
                      width: (MediaQuery.of(context).size.width)/4,
                      child: Text((_decode.length!=0)?"Credits\n\n"+_decode[_str][2]:"Credits\n\nSam Worthington-Zoe Saldaña-Sigourney Weaver-Stephen Lang-Michelle Rodriguez-Giovanni Ribisi-Joel David Moore-CCH Pounder-Wes Studi-Laz Alonso-Dileep Rao-Matt Gerald-Sean Anthony Moran-Jason Whyte-Scott Lawrence-Kelly Kilgour-James Patrick Pitt-Sean Patrick Murphy-Peter Dillon-Kevin Dorman-Kelson Henderson-David Van Horn-Jacob Tomuri-Michael Blain-Rozgay-Jon Curry-Julene Renee-Luke Hawker-Woody Schultz-Peter Mensah-Sonia Yee-Jahnel Curfman-Ilram Choi-Kyla Warren-Alicia Vela-Bailey-Kyle Dryberg-Larry Rew-Dina Morrone",style: TextStyle(color: Colors.red),),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container( height: 25, child: Text((_decode.length!=0)?"Similar Movies":"Top Searched Movies",style: TextStyle(color: Colors.red),),),
              Container(
                  height: 200,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[0]+"?api_key=2824aefff5cfe8c47eeb52ab3a5723ac"):Image.network("https://image.tmdb.org/t/p/w500"+"/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg"+"?api_key=2824aefff5cfe8c47eeb52ab3a5723ac"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[0],style: TextStyle(color: Colors.red),)):Text("Thor: Love and Thunder",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[1]):Image.network("https://image.tmdb.org/t/p/w500"+"/62HCnUTziyWcpDaBO2i1DX17ljH.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[1],style: TextStyle(color: Colors.red))):Text("Top Gun: Maverick",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[2]):Image.network("https://image.tmdb.org/t/p/w500"+"/74xTEgt7R36Fpooo50r9T25onhq.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[2],style: TextStyle(color: Colors.red))):Text("The Batman",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[3]):Image.network("https://image.tmdb.org/t/p/w500"+"/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[3],style: TextStyle(color: Colors.red))):Text("Encanto",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[4]):Image.network("https://image.tmdb.org/t/p/w500"+"/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[4],style: TextStyle(color: Colors.red),)):Text("Blade Runner 2049",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[5]):Image.network("https://image.tmdb.org/t/p/w500"+"/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[5],style: TextStyle(color: Colors.red),)):Text("Parasite",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width/8,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          child:  (img.length!=0)?Image.network("https://image.tmdb.org/t/p/w500"+img[6]):Image.network("https://image.tmdb.org/t/p/w500"+"/khNVygolU0TxLIDWff5tQlAhZ23.jpg"),
                        ),
                        Container(
                          height: 50,
                          child:  (name.length!=0)?Container(height:25,child:Text(name[6],style: TextStyle(color: Colors.red),)):Text("K.G.F: Chapter 2",style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                  ),
                ],
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}


