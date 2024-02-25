import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class User_Orders extends StatefulWidget {
  const User_Orders({super.key});

  @override
  State<User_Orders> createState() => _User_OrdersState();
}

class _User_OrdersState extends State<User_Orders> {
  List<dynamic> _ticketsbought=[];
  String _uid="";
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void initState() {
    _uid=_auth.currentUser!.uid;
    Help().then((List<dynamic> array){
      setState(() {
        _ticketsbought=array;
      });
    });
    super.initState();
  }
  Future<List<dynamic>> Help() async{
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(itemCount:_ticketsbought.length,itemBuilder: (BuildContext context,int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/15,
                      width: MediaQuery.of(context).size.width,
                      child: Text("${index+1}. Contest : ${_ticketsbought[_ticketsbought.length-index-1]["contest"]}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/20,color: Colors.white54)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/20,
                      width: MediaQuery.of(context).size.width,
                      child: Text("Ticket-id : ${_ticketsbought[_ticketsbought.length-index-1]["ticker-id"].toString().substring(0,_ticketsbought[index]["ticker-id"].indexOf("&"))}",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40,color: Colors.white54)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height/40,
                      width: MediaQuery.of(context).size.width,
                      child: Text("Price : 50",style: TextStyle(fontSize: MediaQuery.of(context).size.height/50,color: Colors.white54)),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  )
              ),
            ),
          );
        }),
      ),
    );
  }
}
