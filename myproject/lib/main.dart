// main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer.dart'; // Import the Customer class
import 'order.dart'; // Import the Order class
import 'login_page.dart'; // Import the LoginPage class
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? customersJson = prefs.getStringList('customers');
  List<String>? ordersJson = prefs.getStringList('orders');

  List<Customer> customers = customersJson != null
      ? customersJson.map((customerJson) {
    return Customer.fromJson(json.decode(customerJson));
  }).toList()
      : [];

  List<Order> orders = ordersJson != null
      ? ordersJson.map((orderJson) {
    return Order.fromJson(json.decode(orderJson));
  }).toList()
      : [];

  runApp(MaterialApp(
    home: LoginPage(customers: customers, orders: orders),
  ));
}
