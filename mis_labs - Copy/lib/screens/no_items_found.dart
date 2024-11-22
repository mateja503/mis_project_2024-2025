import 'package:flutter/material.dart';


class NoItemsFound extends StatelessWidget{
  const NoItemsFound({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Center(
      child: Container(
          color: Colors.white,
          child: Text(
            "No Items Found!!",
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