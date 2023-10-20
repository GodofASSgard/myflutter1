// create_order_page.dart

import 'package:flutter/material.dart';
import 'customer.dart'; // Import the Customer class
import 'order.dart'; // Import the Order class
import 'dart:convert'; // Import dart:convert for JSON operations
import 'package:shared_preferences/shared_preferences.dart';

class CreateOrderPage extends StatefulWidget {
  final List<Customer> customers;
  final List<Order> orders;

  CreateOrderPage({required this.customers, required this.orders});

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final TextEditingController timeController = TextEditingController();
  Customer? selectedCustomer;
  List<String> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать заказ'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<Customer>(
                value: selectedCustomer,
                items: widget.customers.map((customer) {
                  return DropdownMenuItem<Customer>(
                    value: customer,
                    child: Text(customer.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Выберите заказчика'),
              ),
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
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  if (selectedCustomer != null && selectedServices.isNotEmpty) {
                    String time = timeController.text;
                    Customer customer = selectedCustomer!;

                    Order newOrder = Order(
                      id: UniqueKey().toString(),
                      customer: customer,
                      cleaningTime: time,
                      services: selectedServices,
                    );

                    widget.orders.add(newOrder);

                    List<String> ordersJson = widget.orders.map((order) {
                      return json.encode(order.toJson());
                    }).toList();

                    await prefs.setStringList('orders', ordersJson);

                    Navigator.pop(context);
                  }
                },
                child: Text('Создать заказ'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
