import 'dart:convert';

import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

var uuid = Uuid();

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.https(
      'purishop-5758-default-rtdb.firebaseio.com',
      '/orders.json',
    );
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return null;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price']),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(
    List<CartItem> cartProducts,
    double total,
  ) async {
    final url = Uri.https(
      'purishop-5758-default-rtdb.firebaseio.com',
      '/orders.json',
    );
    try {
      final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProducts
                .map(
                  (cartItem) => {
                    'id': cartItem.id,
                    'title': cartItem.title,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  },
                )
                .toList(),
          },
        ),
      );
      final res = jsonDecode(response.body);
      final newOrder = OrderItem(
        id: res['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      );
      _orders.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
