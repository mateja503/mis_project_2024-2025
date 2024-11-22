import 'package:flutter/material.dart';


class ErrorMessage extends StatelessWidget{

  final String message;

  const ErrorMessage(this.message);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
          message,
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }

}