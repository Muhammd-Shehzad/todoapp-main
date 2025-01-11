import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';

  DatabaseReference db = FirebaseDatabase.instance.ref('Users');

  void getData() async {
    var snap = await db.child(FirebaseAuth.instance.currentUser!.uid).get();

    if (snap.exists) {
      setState(() {
        name = snap.child('name').value.toString();
        email = snap.child('email').value.toString();
      });
      print(snap.child('name').value.toString());
      print(snap.child('email').value.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.person_2_rounded,
              size: 100.sp,
            ),
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
          Text(
            email,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
