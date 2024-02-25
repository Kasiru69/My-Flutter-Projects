
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottery/SignUp.dart';
import 'package:lottery/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();
  //FirebaseDatabase _ref=FirebaseDatabase.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Sign In",style: TextStyle(fontSize:MediaQuery.of(context).size.height/30,color: Colors.black26 ),),),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: TextFormField(
                      controller: email,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter your email"),
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Don't have a account ? "),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          },
                          child: Text("SignUp",style: TextStyle(color: Colors.blue),),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async{
                      try{
                        await _auth.signInWithEmailAndPassword(email: email.text.toString(), password: password.text.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                      } on FirebaseAuthException catch(e){
                      }
                    },
                    child: Text("Sign-In"),
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
