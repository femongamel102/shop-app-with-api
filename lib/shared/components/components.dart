import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
Widget defaultTextButton(
    {required final VoidCallback function, required String text}) {
  return TextButton(onPressed: function, child: Text(text.toUpperCase()));
}

Widget defaultButton({
  bool isUpperCase = true,
  double width = double.infinity,
  final Color? color = Colors.blue,
  required final VoidCallback onPressed,
  required String text,
  double radius = 10,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(color: Colors.white),
          ),
        ));

Widget defaultTextFormField({
  required TextEditingController controller,
  final TextInputType? keyboardType,
  required String labelText,
  ValueChanged<String>? onChanged,
  IconData? prefixIcon,
  bool isPassword = false,
  IconData? suffixIcon,
  final VoidCallback? suffixPressed,
  ValueChanged<String>? onSubmit,
  FormFieldValidator<String>? validator,
}) =>
    TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffixIcon),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      obscureText: isPassword,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
    );

void showToast({required String msg, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}