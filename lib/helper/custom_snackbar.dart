import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(massage),
      ),
    );
  }