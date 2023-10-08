import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: LoginPage(),
));

class Customer {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String additionalInfo;

  Customer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.additionalInfo,
  });
}

class Order {
  final String id;
  final Customer customer;
  String cleaningTime;
  List<String> services;

  Order({
    required this.id,
    required this.customer,
    required this.cleaningTime,
    required this.services,
  });
}

class LoginPage extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Подтверждение пароля'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Здесь можно добавить код для регистрации
                Navigator.pop(context); // Вернуться на экран входа
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
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
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Здесь можно добавить код для входа
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDashboardPage()),
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

class UserDashboardPage extends StatelessWidget {
  static List<Customer> customers = []; // Список заказчиков
  static List<Order> orders = []; // Список заказов

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
                  MaterialPageRoute(builder: (context) => CustomerCreationPage()),
                );
              },
              child: Text('Создать заказчика'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateOrderPage(customers: customers),
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

class CustomerCreationPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();

  void createCustomer(BuildContext context) {
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

    UserDashboardPage.customers.add(newCustomer);

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
                  createCustomer(context); // Вызываем функцию для создания заказчика
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

class CreateOrderPage extends StatefulWidget {
  final List<Customer> customers;

  CreateOrderPage({required this.customers});

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
                onPressed: () {
                  // Создание заказа и добавление его в список заказов
                  if (selectedCustomer != null && selectedServices.isNotEmpty) {
                    String time = timeController.text;
                    Customer customer = selectedCustomer!;

                    Order newOrder = Order(
                      id: UniqueKey().toString(),
                      customer: customer,
                      cleaningTime: time,
                      services: selectedServices,
                    );

                    UserDashboardPage.orders.add(newOrder);
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

class EditOrderPage extends StatefulWidget {
  final Order order;

  EditOrderPage({required this.order});

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

  void saveChanges(BuildContext context) {
    // Create a copy of the order with the updated values
    final updatedOrder = Order(
      id: widget.order.id,
      customer: widget.order.customer,
      cleaningTime: timeController.text,
      services: selectedServices,
    );

    // Find the index of the original order in the list
    final index = UserDashboardPage.orders.indexWhere((order) => order.id == widget.order.id);

    if (index != -1) {
      // Replace the original order with the updated order
      UserDashboardPage.orders[index] = updatedOrder;
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
                onPressed: () {
                  saveChanges(context); // Сохранить изменения заказа
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

class OrderListPage extends StatelessWidget {
  final List<Order> orders;

  OrderListPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    // Здесь можно реализовать вывод списка заказов
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
                    builder: (context) => EditOrderPage(order: orders[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
