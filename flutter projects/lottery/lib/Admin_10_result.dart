//import 'dart:html';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/foundation.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottery/Admin_home.dart';
class Admin_result extends StatefulWidget {
  const Admin_result({super.key});

  @override
  State<Admin_result> createState() => _Admin_resultState();
}

class _Admin_resultState extends State<Admin_result> {
  File? image;
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _arr=[];
  FirebaseDatabase _ref=FirebaseDatabase.instance;
  TextEditingController _date=new TextEditingController();
  TextEditingController _time=new TextEditingController();
  List<String> items=["10:00 am","06:00 pm","08:00 pm"];
  @override
  void initState() {
    Help().then((List<dynamic> array){
      setState(() {
        print(array);
        _arr=array;
      });
    });
    super.initState();
  }
  Future<List<dynamic>> Help() async{
    List<dynamic> arr=[];
    final ref = FirebaseDatabase.instance.ref("result");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      snapshot.children.forEach((child) {
        print(child.value);
        List<dynamic> it=child.value as List<dynamic>;
        for(Map<dynamic,dynamic> itt in it) arr.add(itt);
        print(arr);
      });
    }
    return arr;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
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
                  InkWell(
                    onTap: () async{
                      XFile? selectedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(selectedimage!=null)
                      {
                        File convert=File(selectedimage!.path);
                        setState(() {
                          image=convert;
                        });
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/2,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: (image!=null)?Image.file(image!,fit: BoxFit.fill,):Center(child: Text("Tap to add image from gallery",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _date,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Enter the date of the contest",
                      ),
                      validator: (value){
                        if(_date.text.toString().length==0) return "Please enter the date";
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _time,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),hintText: "Tap to select the time",
                      ),
                      onTap: (){
                        _showSelectionDialog(context);
                      },
                      validator: (value){
                        if(_time.text.toString().length==0) return "Please enter the time";
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child:Padding(
                      padding: EdgeInsets.only(left:8.0),
                      child: ElevatedButton(onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          print(_date.text.toString());
                          print(_time.text.toString());
                          String picturename=_date.text.toString()+"="+_time.text.toString();
                          UploadTask ut=FirebaseStorage.instance.ref().child(picturename).putFile(image!);
                          TaskSnapshot ts=await ut;
                          String url=await ts.ref.getDownloadURL();
                          print(_arr);
                          _arr.add({
                            "url":url,
                            "date":_date.text.toString(),
                            "time":_time.text.toString()
                          });
                          _ref.ref("result").update({
                            "details":_arr
                          });
                          Navigator.pop(context);
                          //print(url);
                        }
                      }, child: Text("Submit"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                )
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an item'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    _time.text = items[index];
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
