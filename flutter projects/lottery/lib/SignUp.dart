import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottery/main.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController upid=new TextEditingController();
  TextEditingController name=new TextEditingController();
  FirebaseDatabase _ref=FirebaseDatabase.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  List<dynamic> _arr=[];
  @override
  void initState() {
    Help().then((List<dynamic> arr){
      for(dynamic it in arr) _arr.add(it);
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Create your account",style: TextStyle(fontSize:MediaQuery.of(context).size.height/30,color: Colors.black26 ),),),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: email,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your email xxxx@gmail.com"),
                      validator: (value){
                        if(value==null || !value.contains("@gmail.com")) return "Enter a valid email address";
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: password,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your password"),
                      validator: (value){
                        if(value.toString().length<6) return "Your password must contain atleast 6 characters";
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: phone,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your phone number"),
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value.toString().length!=10) return "Enter a valid number";
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: upid,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your Upi-id"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: name,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your Name"),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                        final user=_auth.createUserWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
                        print(_auth.currentUser!.uid);
                        _ref.ref(_auth.currentUser!.uid).set({
                          "name":name.text.toString(),
                          "email":email.text.toString(),
                          "password":password.text.toString(),
                          "upiid":upid.text.toString(),
                          "phone":phone.text.toString(),
                          "userid":_auth.currentUser!.uid.toString(),
                          "wallet":"0"
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                      }
                    },

                    child: Text("Proceed"),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 24)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
