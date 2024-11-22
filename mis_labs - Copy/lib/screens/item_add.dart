import 'package:flutter/material.dart';
import 'package:mis_labs/services/database_helper.dart';
import 'package:mis_labs/models/item_model.dart';

class ItemAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemAdd();
  }
}

class _ItemAdd extends State<ItemAdd> {
  // Controllers for item fields
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController inStoreCountController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  // Method to save the item to the database
  Future<void> saveItem() async {
    // Convert text fields to their respective types

    String name = nameController.text;
    String description = descriptionController.text;
    double? price = double.tryParse(priceController.text);
    int? discount = int.tryParse(discountController.text);
    int? inStoreCount = int.tryParse(inStoreCountController.text);
    String image = imageController.text;



    // Check if required fields are provided
    if (name.isEmpty || price == null || inStoreCount == null || image.isEmpty || description.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    // Create an Item object
    Item newItem = Item(
      name: name,
      description: description,
      price: price,
      discount: discount,
      in_store_count: inStoreCount,
      image: image,
    );

    // Insert the item into the database
    await DatabaseHelper.addItem(newItem);

    // Show confirmation and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item saved successfully")),
    );
    Navigator.pop(context,true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Discount'),
            ),
            TextField(
              controller: inStoreCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'In-Store Count'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
              debugPrint('Save Item Clicked'),
              debugPrint(nameController.text),
                debugPrint(descriptionController.text),
              debugPrint(priceController.text),
              debugPrint(discountController.text),
              debugPrint(inStoreCountController.text),
              debugPrint(imageController.text),
                saveItem()
              },
              child: Text("Save Item"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when done
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    discountController.dispose();
    inStoreCountController.dispose();
    imageController.dispose();
    super.dispose();
  }
}
