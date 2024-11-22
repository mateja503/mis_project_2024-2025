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
      future: DatabaseHelper.getAllItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingToLoad();
        } else if (snapshot.hasError) {
          return ErrorMessage(snapshot.error.toString());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return NoItemsFound();
        } else {
          List<Item> items = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 columns in the grid
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
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
                      AspectRatio(
                        aspectRatio: 16 / 7,
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${item.price.toString()}',
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
