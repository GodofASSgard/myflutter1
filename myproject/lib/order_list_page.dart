// order_list_page.dart

import 'package:flutter/material.dart';
import 'customer.dart'; // Import the Customer class
import 'order.dart'; // Import the Order class
import 'edit_order_page.dart'; // Import the EditOrderPage class

class OrderListPage extends StatelessWidget {
  final List<Order> orders;

  OrderListPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список заказов'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('ФИО заказчика: ${orders[index].customer.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Время клининга: ${orders[index].cleaningTime}'),
                Text('Выбранная услуга: ${orders[index].services.join(", ")}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditOrderPage(order: orders[index], orders: orders)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
