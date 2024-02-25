import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottery/User_Deposit.dart';
import 'package:lottery/User_Withdraw.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _email="",_name="",_phone="",_upi="",_uid="";
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
    print(_email);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lottery"),
      ),
      body: Container(
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
              child: ElevatedButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>User_Withdraw()));
              },
                  child: Text("Withdraw"),
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 40),
                    primary: Colors.red
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                //Navigator.push(context,MaterialPageRoute(builder: (context)=>User_Deposi()));
              },
                child: Text("Deposit"),
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 45),
                    primary: Colors.green
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
