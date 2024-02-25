import 'package:flutter/material.dart';
class Admin_winner extends StatefulWidget {
  const Admin_winner({super.key});

  @override
  State<Admin_winner> createState() => _Admin_winnerState();
}

class _Admin_winnerState extends State<Admin_winner> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users Registered"),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name : aaaa",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                      Text("Email : saptaswadas69@gmail.com",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                      Text("Password : a123456",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                      Text("Phone Number : 1234567890",style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),)
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.green,
                      width: 2.0,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
