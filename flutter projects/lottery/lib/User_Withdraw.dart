import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class User_Withdraw extends StatefulWidget {
  const User_Withdraw({super.key});

  @override
  State<User_Withdraw> createState() => _User_WithdrawState();
}

class _User_WithdrawState extends State<User_Withdraw> {
  String _email="",_name="",_phone="",_upi="",_uid="",_wallet="",_val="";
  TextEditingController _time=new TextEditingController();
  List<int> _arr=[];
  int _Wallet=0,_pending=0,_count=0;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void initState() {
    _uid=_auth.currentUser!.uid.toString();
    Help1().then((dynamic str){
      setState(() {
        _email=str;
        print(_email);
      });
    });
    Help2().then((dynamic str){
      setState(() {
        _name=str;
        print(_name);
      });
    });
    Help3().then((dynamic str){
      setState(() {
        _phone=str;
        print(_phone);
      });
    });
    Help4().then((dynamic str){
      setState(() {
        _upi=str;
        print(_upi);
      });
    });
    Help6().then((dynamic str){
      setState(() {
        _pending=int.parse((str==null)?"0":str);
        print(_pending);
      });
    });
    Help5().then((dynamic str){
      setState(() {
        _wallet=str[0].toString();
        _Wallet=int.parse(_wallet);
        _pending=int.parse(str[1].toString());
        for(int i=0;i<=max(_Wallet-_pending,0);i++) _arr.add(i);
        print("${_Wallet} ${_pending}");
      });
    });
    /*Help6().then((dynamic str){
      setState(() {
        _pending=int.parse((str==null)?"0":str);
        print(_pending);
      });
    });*/
    super.initState();
  }
  Future<dynamic> Help1() async{
    dynamic ans="";
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("email").get();
    ans=snapshot.value as dynamic;
    return ans;
  }
  Future<dynamic> Help2() async{
    dynamic ans="";
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("name").get();
    ans=snapshot.value as dynamic;
    return ans;
  }
  Future<dynamic> Help3() async{
    dynamic ans="";
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("phone").get();
    ans=snapshot.value as dynamic;
    return ans;
  }
  Future<dynamic> Help4() async{
    dynamic ans="";
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("upiid").get();
    ans=snapshot.value as dynamic;
    return ans;
  }
  Future<dynamic> Help5() async{
    dynamic ans=[];
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("wallet").get();
    final ref2=FirebaseDatabase.instance.ref(_uid);
    final snapshot2=await ref.child("pending").get();
    //ans=snapshot.value as dynamic;
    ans.add(snapshot.value as dynamic);
    ans.add(snapshot2.value as dynamic);
    return ans;
  }
  Future<dynamic> Help6() async{
    dynamic ans="";
    final ref=FirebaseDatabase.instance.ref(_uid);
    final snapshot=await ref.child("pending").get();
    ans=snapshot.value as dynamic;
    return ans;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Withdraw"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("Name : ${_name}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("Email : ${_email}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("Phone No : ${_phone}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("Upi_Id : ${_upi}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("Wallet : ${_wallet}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    child: Text("User-Id : ${_uid}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      _showSelectionDialog(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/20,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color:Colors.green,
                            width: 2.0,
                          )
                      ),
                      child: Text("Selected Amount : ${_val}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width,
                    child: Text("Take ScreenShot and send to the following whatsapp number: +91 XXXXXXXXXX"),
                  ),
                ),
                (_count==0)?ElevatedButton(onPressed: (){
                  setState(() {
                    final ref=FirebaseDatabase.instance.ref(_uid);
                    ref.update({
                      "pending":(_pending+int.parse(_val)).toString()
                    });
                    _count++;
                  });
                },
                    child: Text("Are you sure, You want to deposit ??"),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.green
                  ),
                ):ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                },
                    child: Text("Have you sent screenshot to the number ??"),
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.green
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showSelectionDialog(BuildContext context) {
    int _count=0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select the amount'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _arr.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    setState(() {
                      _val=_arr[index].toString();
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/20,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color:Colors.black26,
                          width: 2.0,
                        )
                    ),
                    child: Text("${_arr[index].toString()}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
