import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/Custom_widget/custom_button.dart';
import 'package:todoapp/UI/Home/home_screen.dart';
import 'package:todoapp/UI/auth/SignUp/sign_up.dart';
import 'package:todoapp/Utils/toast_poppup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  void logIn() {
    auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((v) {
      ToastPoppup().toast('Sign In Successfuly', Colors.green, Colors.white);

      setState(() {
        isLoading = false;
        emailController.clear();
        passwordController.clear();
      });
    }).onError((Error, v) {
      ToastPoppup().toast(Error.toString(), Colors.red, Colors.white);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
              color: Colors.pink, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In Your Account',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Email';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    logIn();
                  }
                  // if (_formKey.currentState!.validate()) {
                  //   if (emailController.text.isNotEmpty &&
                  //       passwordController.text.isNotEmpty) {
                  //     ToastPoppup()
                  //         .toast('Account Created', Colors.green, Colors.white);
                  //     setState(() {
                  //       isLoading = true;
                  //     });
                  //   } else {
                  //     ToastPoppup().toast(
                  //         'Account not Created', Colors.green, Colors.white);
                  //     setState(() {
                  //       isLoading = false;
                  //     });
                  //   }
                  // }
                },
                text: 'Sign In',
                color: [
                  Colors.pink.withOpacity(.9),
                  Colors.pinkAccent.withOpacity(.6)
                ],
                height: 50.h,
                weight: 330.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do Not have Account?',
                      style: TextStyle(fontSize: 16.sp)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
