import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    this.isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    final url = Uri.https(
      'purishop-5758-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );
    try {
      final response = await http.patch(
        url,
        body: jsonEncode(
          {
            'isFavorite': this.isFavorite,
          },
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
      throw error;
    }
  }
}
