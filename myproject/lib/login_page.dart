// login_page.dart

import 'package:flutter/material.dart';
import 'customer.dart'; // Import the Customer class from the appropriate file
import 'order.dart'; // Import the Order class from the appropriate file
import 'registration_page.dart'; // Import the RegistrationPage class
import 'login_screen.dart'; // Import the LoginScreen class


class LoginPage extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  LoginPage({required this.customers, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход или Регистрация'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: Text('Регистрация'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(customers: customers, orders: orders)),
                );
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
