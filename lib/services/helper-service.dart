import 'package:fluttertoast/fluttertoast.dart';

class HelperService {
  void displayToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
    );
  }
}
