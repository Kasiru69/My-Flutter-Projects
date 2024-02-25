import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Winner_result extends StatefulWidget {
  const Winner_result({super.key});

  @override
  State<Winner_result> createState() => _Winner_resultState();
}

class _Winner_resultState extends State<Winner_result> {
  List<dynamic> _arr=[];
  FirebaseDatabase _ref=FirebaseDatabase.instance;
  @override
  void initState() {
    Help().then((List<dynamic> array){
      setState(() {
        print(array);
        _arr=array;
      });
    });
    super.initState();
  }
  Future<List<dynamic>> Help() async{
    List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref("result");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.children.forEach((child) {
        print(child.value);
        List<dynamic> it=child.value as List<dynamic>;
        for(Map<dynamic,dynamic> itt in it) arr.add(itt);
        print(arr);
      });
    }
    return arr;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Winner Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(itemCount:_arr.length,itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: InkWell(
                        onTap: (){
                          _showImageDialog(context,_arr[_arr.length-index-1]["url"]);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height/4,
                          width: 2*MediaQuery.of(context).size.width/4,
                          child: Image.network(_arr[_arr.length-index-1]["url"].toString(),fit: BoxFit.fill,),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Date : ${_arr[_arr.length-index-1]["date"]}"),
                        Text("Time : ${_arr[_arr.length-index-1]["time"]}"),
                        IconButton(onPressed: (){
                          setState(() {
                            _arr.removeAt(index);
                            _ref.ref("result").update({
                              "details":_arr
                            });
                          });
                        }, icon: Icon(Icons.delete))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
  void _showImageDialog(BuildContext context,String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          content: Container(
            width: double.maxFinite,
            child: Image.network(url,fit: BoxFit.fill,),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
