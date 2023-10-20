// user_dashboard_page.dart

import 'package:flutter/material.dart';
import 'customer.dart';
import 'order.dart';
import 'customer_creation_page.dart';
import 'create_order_page.dart';
import 'order_list_page.dart';

class UserDashboardPage extends StatelessWidget {
  final List<Customer> customers;
  final List<Order> orders;

  UserDashboardPage({required this.customers, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Панель пользователя'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerCreationPage(customers: customers)),
                );
              },
              child: Text('Создать заказчика'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateOrderPage(customers: customers, orders: orders),
                  ),
                );
              },
              child: Text('Создать заказ'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderListPage(orders: orders)),
                );
              },
              child: Text('Список заказов'),
            ),
          ],
        ),
      ),
    );
  }
}
