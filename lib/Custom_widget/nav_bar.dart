import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';

class NavBar extends StatefulWidget {
  NavBar({
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String name = '';
  String email = '';

  TextEditingController navBarController = TextEditingController();
  DatabaseReference db = FirebaseDatabase.instance.ref('Users');

  void getData() async {
    var snap = await db.child(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      setState(() {
        name = snap.child('name').value.toString();
        email = snap.child('email').value.toString();
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFEBEE), // Light pastel pink
                  Color(0xFFF8BBD0), // Medium pink tone
                  Color(0xFFF48FB1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            accountName: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/s.PNG'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
