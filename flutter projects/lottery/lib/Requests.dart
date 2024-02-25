import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List<dynamic> _arr=[];
  final _formKey = GlobalKey<FormState>();
  TextEditingController userid=new TextEditingController();
  TextEditingController money=new TextEditingController();
  @override
  void initState() {
    Help().then((List<dynamic> arr){
      setState(() {
        for(dynamic it in arr) _arr.add(it.toString());
        print(_arr);
      });
    });
    super.initState();
  }
  Future<List<dynamic>> Help()async{
    List<dynamic> arr=[];
    final ref=FirebaseDatabase.instance.ref("USERS").child("lists");
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
      appBar: AppBar(title: Text("Give Money"),),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: userid,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter the user-id"),
                  validator: (value){
                    if(value==null || !_arr.contains(value)) return "No such userid excist";
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/50,
                ),
                TextFormField(
                  controller: money,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter the amount"),
                  validator: (value){
                    if(value.toString().length==0) return "Enter the amount";
                    return null;
                  },
                ),
                Center(
                  child: ElevatedButton(onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      String uid=userid.text.toString();
                      print(uid);
                      final ref=FirebaseDatabase.instance.ref(uid);
                      final snapshot1=await ref.child("wallet").get();
                      final snapshot2=await ref.child("pending").get();
                      String Money=snapshot1.value as String;
                      String pending=snapshot2.value as String;
                      ref.update({
                        "wallet": (int.parse(Money)-int.parse(money.text.toString())).toString(),
                        "pending": (max(0,int.parse(pending)-int.parse(money.text.toString()))).toString()
                      });
                      userid.text="";
                      money.text="";
                    }
                  },
                      child: Text("Send"),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 24)
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
