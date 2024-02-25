import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottery/Admin_home.dart';
import 'package:lottery/Admin_request.dart';
import 'package:lottery/Admin_winner.dart';
import 'package:lottery/Requests.dart';
import 'package:lottery/Winner_result.dart';
class Admin_main extends StatefulWidget {
  const Admin_main({super.key});

  @override
  State<Admin_main> createState() => _Admin_mainState();
}

class _Admin_mainState extends State<Admin_main> {
  List<Widget> _arr=[Admin_home(),Winner_result(),Requests(),Admin_winner()];
  int _index=0;
  @override
  void initState() {
    //Help().then((List<dynamic>arr){});
    super.initState();
  }
  /*Future<List<dynamic>> Help()async{
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
    arr.add("yNWc0L2ZrUUmQKTDI0zPrJu3etU2");
    FirebaseDatabase.instance.ref("USERS").update({
      "lists":arr
    });
    return arr;
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _arr[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.waves),label: "Results"),
          BottomNavigationBarItem(icon: Icon(Icons.request_page),label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: "Users")
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index){
          setState(() {
            _index=index;
          });
        },
      ),
    );
  }
}
