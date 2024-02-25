import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottery/Admin_Main.dart';
import 'package:lottery/Home.dart';
import 'package:lottery/Login.dart';
import 'package:lottery/Profile.dart';
import 'package:lottery/Requests.dart';
import 'package:lottery/SignUp.dart';
import 'package:lottery/User_orders.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: "AIzaSyDPnOdV--yXckIF3h7cfr3O5tM1353xteQ",
      authDomain: "lottery-ebbb1.firebaseapp.com",
      projectId: "lottery-ebbb1",
      storageBucket: "lottery-ebbb1.appspot.com",
      messagingSenderId: "992881881891",
      appId: "1:992881881891:android:a94dc1fc4bc1bbad9d9296",
      databaseURL: "https://lottery-ebbb1-default-rtdb.firebaseio.com",
    )
  );
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser!=null)?((FirebaseAuth.instance.currentUser!.uid.toString()=="CYKtIkhB3ROnzAfcz5rNs0KMEJ03")?Admin_main():Main()):Login(),
      //home: Main(),
    );
  }
}
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<Widget> _arr=[Home(),User_Orders(),Profile()];
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _arr[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
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


