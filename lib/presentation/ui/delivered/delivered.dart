import 'package:flutter/material.dart';

class DeliveredScreen extends StatefulWidget {
  const DeliveredScreen({Key? key}) : super(key: key);

  @override
  State<DeliveredScreen> createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Yetkazildi',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Sora',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.check_circle,color: Colors.green,),
            title: Text('Order #12345'),
            subtitle: Text('Delivery Address: 123 Main St, City, Country'),
            trailing: Text('Status: Delivered'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle,color: Colors.green,),
            title: Text('Order #67890'),
            subtitle: Text('Delivery Address: 456 Elm St, City, Country'),
            trailing: Text('Status: Delivered'),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}

