import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class User_10 extends StatefulWidget {
  const User_10({super.key});

  @override
  State<User_10> createState() => _User_10State();
}

class _User_10State extends State<User_10> {
  List<dynamic> _arr=[];
  List<dynamic> _status=[];
  List<dynamic> _original=[];
  List<dynamic> _map=[];
  List<dynamic> _ticketsbought=[];
  List<int> _choseindex=[];
  FirebaseAuth _auth=FirebaseAuth.instance;
  String _uid="",_flag="",_wallet="";
  int _Wallet=0,_pending=0;
  @override
  void initState() {
    _uid=_auth.currentUser!.uid.toString();

    Help5().then((dynamic str){
      setState(() {
        _wallet=str[0].toString();
        _Wallet=int.parse(_wallet);
        _pending=int.parse(str[1].toString());
        print("${_Wallet} ${_pending}");
      });
    });
    Help3().then((dynamic ans){
      setState(() {
        _flag=ans;
        print(_flag);
      });
    });
    Help2().then((List<dynamic> array){
      setState(() {
        print(array);
        _map=array;
      });
    });
    Help6().then((List<dynamic> array){
      setState(() {
        print(array);
        _ticketsbought=array;
      });
    });
    Help().then((List<dynamic> array){
      setState(() {
        for(int i=0;i<array.length;i++)
          {
            _original.add(array[i].toString());
            _arr.add(array[i].toString().substring(0,array[i].indexOf("&")));
            _status.add(array[i].toString().substring(array[i].indexOf("&")+1,array[i].toString().length));
            print(_arr);
            print(_status);
          }
      });
    });
    super.initState();
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
  Future<dynamic> Help3() async{
    dynamic ans="";
    final ref = FirebaseDatabase.instance.ref("10:00am").child("flag");
    final snapshot = await ref.get();
    //print(snapshot.value);
    ans=snapshot.value;
    //print(ans);
    return ans;
  }
  Future<List<dynamic>> Help6() async{
    List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref(_uid);
    final snapshot = await ref.child("tickets").get();
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
  Future<List<dynamic>> Help() async{
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
        title: Text("10:00 am Contest"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height:MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    )
                ),
                child: (_arr.length>0 && _flag=="yes")?ListView.builder(itemCount:_arr.length,itemBuilder:(BuildContext context,int index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        if(!_choseindex.contains(index) && _status[index]=="0")
                        _choseindex.add(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height:MediaQuery.of(context).size.height/20 ,
                        width: MediaQuery.of(context).size.width,
                        child: Text("${_arr[index]}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                        decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: (_status[index]=="0")?Colors.green:Colors.red,
                              width: 2.0,
                            )
                        ),
                      ),
                    ),
                  );
                }):Center(
                  child: Text("No Tickets",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                ),
             ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tickets",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                    Text("${_choseindex.length} X",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                child: (_choseindex.length>0)?ListView.builder(itemCount:_choseindex.length,itemBuilder: (BuildContext context,int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height:MediaQuery.of(context).size.height/20 ,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color:Colors.black26,
                            width: 2.0,
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${_arr[_choseindex[index]]}",style: TextStyle(fontSize:MediaQuery.of(context).size.height/40 ),),
                          IconButton(onPressed: (){
                            setState(() {
                              _choseindex.removeAt(index);
                            });
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                }):Center(
                  child: Text("No Tickets selected",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Order",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                    Text("${_choseindex.length*50}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40))
                  ],
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              int money=_choseindex.length*50;
              if((_Wallet-_pending)>=money){
              setState(() {
                for(int i=0;i<_choseindex.length;i++){
                  dynamic x=_arr[_choseindex[i]]+"&1";
                  _original[_choseindex[i]]=x;
                  _map.add({
                    "ticker-id":_original[_choseindex[i]],
                    "Buyer":_uid
                  });
                  _ticketsbought.add({
                    "ticker-id":_original[_choseindex[i]],
                    "contest":"10:00 am"
                  });
                }
                final ref = FirebaseDatabase.instance.ref("10:00am");
                ref.update({
                  "list":_original,
                  "buyer":_map,
                });
                final ref2 = FirebaseDatabase.instance.ref(_uid);
                ref2.update({
                  "tickets":_ticketsbought
                });
                Navigator.pop(context);
              });
              }
              else{
                print("ok");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You don't have enough money in your wallet")),
                );
              }
            }, child: Text("Buy"),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 40),
                  primary: Colors.green
              ),
            )
        ],
      ),
      ),
    );
  }
}
