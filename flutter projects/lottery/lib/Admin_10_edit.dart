import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Admin_10_edit extends StatefulWidget {
  const Admin_10_edit({super.key});

  @override
  State<Admin_10_edit> createState() => _Admin_10_editState();
}

class _Admin_10_editState extends State<Admin_10_edit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _ticket=new TextEditingController();
  final _ref=FirebaseDatabase.instance.ref();
  List<dynamic> _ticketarr=[];
  List<dynamic> _map=[];
  @override
  void initState() {
    Help2().then((List<dynamic> array){
      setState(() {
        print(array);
        _map=array;
      });
    });
    fetchticketnumbers().then((List<dynamic> arr){
      setState(() {
        for(int i=0;i<arr.length;i++) _ticketarr.add(arr[i]);
        print(_ticketarr);
      });
    });
    super.initState();
  }
  Future<List<dynamic>> Help2() async{
    List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref("10:00am");
    final snapshot = await ref.child("buyer").get();
    if (snapshot.exists) {
      snapshot.children.forEach((child) {
        print(child.value);
        Map<dynamic,dynamic> it=child.value as Map<dynamic,dynamic>;
        arr.add(it);
        print(arr);
      });
    }
    return arr;
  }
  Future<List<dynamic>> fetchticketnumbers() async{
    late List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref("10:00am").child("list");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.children.forEach((child) {
        print(child.value);
        dynamic it=child.value as dynamic;
        arr.add(it);
      });
    }
    return arr;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit 10:00 am contest"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white54,
                    child: Text("Price : 50",style: TextStyle(fontSize: MediaQuery.of(context).size.height/30),),
                  ),
                  TextFormField(
                    controller: _ticket,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter a ticket number",
                        suffixIcon: IconButton(
                          onPressed: ()async{
                            setState(() {
                              _ticketarr.add(_ticket.text.toString()+"&0");
                              _ref.child("10:00am").update({
                                "list":_ticketarr
                              });
                            });
                            _ticket.clear();
                          },
                          icon: Icon(Icons.add),
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 2.1*MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0
                      )
                    ),
                    child: (_ticketarr.length>0)?ListView.builder(itemCount: _ticketarr.length,
                      itemBuilder: (BuildContext context,int index){
                      return Padding(
                        padding: const EdgeInsets.only(top:2.0,bottom: 2.0,left: 1.0,right: 1.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/20,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2.0,

                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${_ticketarr[index].toString().substring(0,_ticketarr[index].indexOf("&"))}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/30),),
                              (_ticketarr[index].toString().substring(_ticketarr[index].indexOf("&")+1,_ticketarr[index].toString().length)=="0")?IconButton(onPressed: ()async{
                                setState(() {
                                  _ticketarr.removeAt(index);
                                  _ref.child("10:00am").update({
                                    "list":_ticketarr
                                  });
                                });
                              }, icon: Icon(Icons.delete)):Center()
                            ],
                          )
                        ),
                      );
                      },
                    ):Center(child: Text("No Tickets",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Container(
                      height: MediaQuery.of(context).size.height/15,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: (){
                            _ticketarr=[];
                            _map=[];
                            setState(() {
                              _ref.child("10:00am").update({
                                "list":_ticketarr,
                                "flag":"no",
                                "buyer":_map
                              });
                            });
                          },
                          child: Text("Close Contest"),
                          style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(fontSize: 40),
                            primary: Colors.red
                          ),
                        ),
                      ),
                    )
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Container(
                        height: MediaQuery.of(context).size.height/15,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: (){
                              //_ticketarr=[];
                              setState(() {
                                _ref.child("10:00am").update({
                                  "flag":"yes"
                                });
                              });
                            },
                            child: Text("Start Contest"),
                            style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(fontSize: 40),
                                primary: Colors.green
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
