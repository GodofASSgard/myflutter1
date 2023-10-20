// login_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer.dart';
import 'order.dart';
import "user_dashboard_page.dart";

class LoginScreen extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  LoginScreen({required this.customers, required this.orders});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                getUserData().then((userData) {
                  if (userData['email'] == emailController.text && userData['password'] == passwordController.text) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDashboardPage(customers: customers, orders: orders)),
                    );
                  }
                });
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    return {'email': email, 'password': password};
  }
}
