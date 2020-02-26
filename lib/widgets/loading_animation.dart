import 'package:flutter/material.dart';

Widget loadingIcon({Color color}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? Color(0xFF047353),
      ),
    ),
  );
}
