import 'package:flutter/material.dart';




class WaitingToLoad extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.white,
        child:  CircularProgressIndicator()
      ),
    );
  }

}