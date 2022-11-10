import 'package:flutter/material.dart';
import 'package:demo_project/utils/styles/styles.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    Key? key,
    required this.onPressed,
    required this.btnName,
  }) : super(key: key);
  final void Function() onPressed;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: KColor.secondary.color),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


 