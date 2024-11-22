import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../services/database_helper.dart';
import 'error_message.dart';
import 'no_items_found.dart';


class ItemDetail extends StatefulWidget{

  final int? id;

  const ItemDetail({super.key, this.id});




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemDetail(id);
  }

}

class _ItemDetail extends State<ItemDetail>{
  int? id;

  _ItemDetail(this.id);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: DatabaseHelper.getItem(id!),
        builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
            return ErrorMessage(snapshot.error.toString());  // Error handling
            } else if (!snapshot.hasData || snapshot.data == null) {
            return NoItemsFound();  // No data found
            } else {
                Item item = snapshot.data!;
                return  Scaffold(
                  appBar: AppBar(
                  title: const Text("211188"),
                  centerTitle: true,
                  elevation: 200.0,
                ),
                  body: Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Assuming the item has an image field for display
                        Expanded(
                          child: Image.network(
                            item.image, // Use the image URL or asset path
                            fit: BoxFit.cover, // Make the image cover the space
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.name,  // Display the item's name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.description,  // Display the item's name
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '\$${item.price.toString()}',  // Display the price of the item
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }

        }
    );
  }




}