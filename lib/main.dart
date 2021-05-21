import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purishop_app/providers/auth.dart';
import 'package:purishop_app/screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_product_screen.dart';
import './providers/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PuriShop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        home: AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
