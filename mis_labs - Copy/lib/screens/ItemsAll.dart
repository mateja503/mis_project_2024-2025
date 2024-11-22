import 'package:flutter/material.dart';
import 'package:mis_labs/screens/waiting_to_load.dart';
import 'package:mis_labs/services/database_helper.dart';
import 'package:mis_labs/models/item_model.dart';

import 'error_message.dart';
import 'item_detail.dart';
import 'no_items_found.dart';

class ItemsListAll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemsListAll();
  }
}

class _ItemsListAll extends State<ItemsListAll> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>?>(
      future: DatabaseHelper.getAllItems(),  // Fetch all items from the database
      builder: (context, snapshot) {
        // Check if data is available
        if (snapshot.connectionState == ConnectionState.waiting) {
          //return Center(child: CircularProgressIndicator());// Loading indicator
          return WaitingToLoad();
        } else if (snapshot.hasError) {
          return ErrorMessage(snapshot.error.toString());  // Error handling
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoItemsFound();  // No data found
        } else {
          // If data is available, show it in the grid
          List<Item> items = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns in the grid
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
            ),
            itemCount: items.length, // Number of items in the grid
            itemBuilder: (context, index) {
              Item item = items[index];

              return GestureDetector(
                onTap: () => {
                  debugPrint('The detail page has been pushed ${item.id}'),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetail(id: item.id!),
                    ),
                  ),
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Assuming the item has an image field for display
                      AspectRatio(
                        aspectRatio: 16 / 7,
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
            },
          );
        }
      },
    );
  }
}
