// edit_order_page.dart

import 'package:flutter/material.dart';
import 'customer.dart'; // Import the Customer class
import 'order.dart'; // Import the Order class
import 'dart:convert'; // Import dart:convert for JSON operations
import 'package:shared_preferences/shared_preferences.dart';

class EditOrderPage extends StatefulWidget {
  final Order order;
  final List<Order> orders;

  EditOrderPage({required this.order, required this.orders});

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  final TextEditingController timeController = TextEditingController();
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    timeController.text = widget.order.cleaningTime;
    selectedServices = List.from(widget.order.services);
  }

  void saveChanges(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final updatedOrder = Order(
      id: widget.order.id,
      customer: widget.order.customer,
      cleaningTime: timeController.text,
      services: selectedServices,
    );

    final index = widget.orders.indexWhere((order) => order.id == widget.order.id);

    if (index != -1) {
      widget.orders[index] = updatedOrder;

      List<String> ordersJson = widget.orders.map((order) {
        return json.encode(order.toJson());
      }).toList();

      await prefs.setStringList('orders', ordersJson);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать заказ'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Время клининга'),
              ),
              DropdownButtonFormField<String>(
                value: selectedServices.isNotEmpty ? selectedServices[0] : null,
                items: ['Поливка растений', 'Мытье полов', 'Протирание пыли']
                    .map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedServices = [value!];
                  });
                },
                decoration: InputDecoration(labelText: 'Выберите услуги'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  saveChanges(context);
                },
                child: Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
