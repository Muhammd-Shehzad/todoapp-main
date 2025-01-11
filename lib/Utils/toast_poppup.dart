import 'package:fluttertoast/fluttertoast.dart';

class ToastPoppup {
  void toast(message, bcolor, textcolor) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        textColor: textcolor,
        backgroundColor: bcolor,
        toastLength: Toast.LENGTH_LONG);
  }
}
