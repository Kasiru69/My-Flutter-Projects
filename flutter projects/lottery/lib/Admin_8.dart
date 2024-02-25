import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Admin_8 extends StatefulWidget {
  const Admin_8({super.key});

  @override
  State<Admin_8> createState() => _Admin_8State();
}

class _Admin_8State extends State<Admin_8> {
  FirebaseDatabase _ref=FirebaseDatabase.instance;
  dynamic _check="";
  int _index=-1;
  List<dynamic> _flag=["Contest has ended","Contest is running"];
  List<dynamic> _part=[];
  void initState() {
    Getup().then((dynamic ans){
      setState(() {
        _check=ans;
        if(_check=="yes") _index=1;
        else _index=0;
        print(_check);
      });
    });
    Help().then((List<dynamic> ans){
      setState(() {
        _part=ans;
      });
    });
    //print(check);
    super.initState();
  }
  Future<List<dynamic>> Help() async{
    List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref("08:00pm").child("buyer");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.children.forEach((child) {
        //print(child.value);
        Map<dynamic,dynamic> it=child.value as Map<dynamic,dynamic>;
        arr.add(it);
        //print(arr);
      });
    }
    return arr;
  }
  Future<dynamic> Getup() async{
    dynamic ans="";
    final ref = FirebaseDatabase.instance.ref("08:00pm").child("flag");
    final snapshot = await ref.get();
    print(snapshot.value);
    ans=snapshot.value;
    return ans;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("08:00 pm contest"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height:MediaQuery.of(context).size.height/30,
                width:MediaQuery.of(context).size.width,
                child: (_index==1)?Text("${_flag[1]}",style: TextStyle(color: Colors.green,fontSize:MediaQuery.of(context).size.height/40 ),):
                Text("${_flag[0]}",style: TextStyle(color: Colors.red,fontSize:MediaQuery.of(context).size.height/40 ),),
              ),
              Container(
                height:MediaQuery.of(context).size.height/14 ,
                width:MediaQuery.of(context).size.width,
                child: Text("Contestants",style: TextStyle(fontSize:MediaQuery.of(context).size.height/15),),
              ),
              SizedBox(
                height:MediaQuery.of(context).size.height/15 ,
              ),
              Container(
                height: 2.1*MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(itemCount: _part.length,itemBuilder: (BuildContext context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("User Id : ${_part[index]['Buyer']}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ticket No. : ${_part[index]['Buyer']}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.green,
                            width: 2.0,

                          )
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
