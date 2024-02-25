import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottery/User_10.dart';
import 'package:lottery/User_6.dart';
import 'package:lottery/User_8.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _uid="";
  FirebaseAuth _auth=FirebaseAuth.instance;
  String _wallet="",_pending="";
  @override
  void initState() {
    _uid=_auth.currentUser!.uid.toString();
    Help().then((dynamic arr){
      setState(() {
        _wallet=arr[0].toString();
        _pending=arr[1].toString();
      });
    });
    super.initState();
  }
  Future<dynamic> Help() async{
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lottery"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/30,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.wallet),
                          Text("Wallet : ${_wallet}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height/50)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.pending),
                          Text("Pending : ${_pending}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height/50)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>User_10()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("10:00 am contest",style: TextStyle(color: Colors.white54,fontSize: 50),)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>User_6()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("06:00 pm contest",style: TextStyle(color: Colors.white54,fontSize: 50),)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>User_8()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("08:00 pm contest",style: TextStyle(color: Colors.white54,fontSize: 50),)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
