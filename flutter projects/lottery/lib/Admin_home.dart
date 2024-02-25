import 'package:flutter/material.dart';
import 'package:lottery/Admin_10.dart';
import 'package:lottery/Admin_10_edit.dart';
import 'package:lottery/Admin_10_result.dart';
import 'package:lottery/Admin_6.dart';
import 'package:lottery/Admin_6_edit.dart';
import 'package:lottery/Admin_8.dart';
import 'package:lottery/Admin_8_edit.dart';
import 'package:lottery/main.dart';
class Admin_home extends StatefulWidget {
  const Admin_home({super.key});

  @override
  State<Admin_home> createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lottery"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:MediaQuery.of(context).size.height/6,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text("10:00 am Contest",style: TextStyle(color: Colors.white54,fontSize: 50),)
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Admin_10()));
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_10_edit()));
                            }, child: Text("Edit"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_result()));
                            }, child: Text("Result"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:MediaQuery.of(context).size.height/6,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text("06:00 pm Contest",style: TextStyle(color: Colors.white54,fontSize: 50),)
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Admin_6()));
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Admin_6_edit()));
                            }, child: Text("Edit"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_result()));
                            }, child: Text("Result"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height:MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height:MediaQuery.of(context).size.height/6,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child:Text("08:00 pm Contest",style: TextStyle(color: Colors.white54,fontSize: 50),)
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => Admin_8()));
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Admin_8_edit()));
                            }, child: Text("Edit"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_result()));
                            }, child: Text("Result"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      )
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)
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
