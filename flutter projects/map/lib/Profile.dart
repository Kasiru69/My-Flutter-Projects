import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          height: MediaQuery.of(context).size.height/4,
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Saptaswa"),
                  CircleAvatar()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
