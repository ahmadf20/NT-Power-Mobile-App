import 'package:flutter/material.dart';

Widget loadingIcon() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Color(0xFF047353),
      ),
    ),
  );
}
