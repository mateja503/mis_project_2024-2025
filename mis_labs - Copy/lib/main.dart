import 'package:flutter/material.dart';
import 'package:mis_labs/screens/item_add.dart';
import '../screens/ItemsAll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'ClothesShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("211188"),
        centerTitle: true,
        elevation: 200.0,
      ),
      body: ItemsListAll(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint('FAB clicked');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemAdd(),
            ),
          );
          if (result == true) {
            setState(() {});  
          }
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}



