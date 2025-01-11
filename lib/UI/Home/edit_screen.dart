import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';
import 'package:todoapp/Utils/toast_poppup.dart';

class EditScreen extends StatefulWidget {
  EditScreen({super.key, this.title, this.description, this.id});

  final title;
  final description;
  final id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DatabaseReference db = FirebaseDatabase.instance.ref('todo');

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    editTitleController.text = widget.title.toString();
    editDescController.text = widget.description.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Page',
          style: TextStyle(
              color: Colors.pink, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
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
              'Edit Now',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: editTitleController,
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
                controller: editDescController,
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
                db.child(widget.id).update({
                  'title': editTitleController.text.trim(),
                  'description': editDescController.text.trim()
                }).then((value) {
                  ToastPoppup().toast('Upadted', Colors.green, Colors.white);
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  ToastPoppup()
                      .toast(error.toString(), Colors.red, Colors.white);
                });
              },
              text: 'Update',
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
