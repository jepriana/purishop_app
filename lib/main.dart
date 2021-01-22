import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'Purishop',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Purishop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop app!'),
      ),
    );
  }
}
