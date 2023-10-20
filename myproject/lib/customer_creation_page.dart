// customer_creation_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'customer.dart';

class CustomerCreationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();
  final List<Customer> customers;

  CustomerCreationPage({required this.customers});

  void createCustomer(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;
    String additionalInfo = additionalInfoController.text;

    Customer newCustomer = Customer(
      id: UniqueKey().toString(),
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      additionalInfo: additionalInfo,
    );

    customers.add(newCustomer);

    List<String> customersJson = customers.map((customer) {
      return json.encode(customer.toJson());
    }).toList();

    await prefs.setStringList('customers', customersJson);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создать заказчика'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'ФИО заказчика'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Номер телефона'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email заказчика'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: additionalInfoController,
                decoration: InputDecoration(labelText: 'Дополнительные сведения'),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  createCustomer(context);
                },
                child: Text('Создать заказчика'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
