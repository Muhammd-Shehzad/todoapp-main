import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';
import 'package:todoapp/Utils/toast_poppup.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  bool isdataLoaded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios))),
        title: Text(
          'Add Data',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEBEE), // Light pastel pink
              Color(0xFFF8BBD0), // Medium pink tone
              Color(0xFFF48FB1), // Slightly darker pink
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Data Now',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('title'),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  border: OutlineInputBorder(
                    gapPadding: 4.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: desController,
                maxLines: 5,
                decoration: InputDecoration(
                  label: Text('description'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomButton(
              onPressed: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                if (titleController.text.isEmpty &&
                    desController.text.isEmpty) {
                  ToastPoppup()
                      .toast('Pleas add data', Colors.green, Colors.white);
                  setState(() {
                    isdataLoaded = false;
                  });
                  return;
                } else {
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  db.collection('todo').doc(id).set({
                    'tilte': titleController.text.toString().trim(),
                    'description': desController.text.toString().trim(),
                    'id': id,
                  }).then((v) {
                    ToastPoppup()
                        .toast('Data Added', Colors.green, Colors.white);
                    titleController.clear();
                    desController.clear();
                    setState(() {
                      isdataLoaded = true;
                    });
                  }).onError(
                    (Error, v) {
                      ToastPoppup()
                          .toast(Error.toString(), Colors.red, Colors.white);
                      setState(
                        () {
                          isdataLoaded = false;
                        },
                      );
                    },
                  );
                }
              },
              text: 'Add Data',
              height: 50.h,
              weight: 340.w,
              color: [
                Colors.pink.withOpacity(.9),
                Colors.pinkAccent.withOpacity(.6)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
