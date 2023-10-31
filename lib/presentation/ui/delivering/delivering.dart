import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveringScreen extends StatefulWidget {
  const DeliveringScreen({Key? key}) : super(key: key);

  @override
  State<DeliveringScreen> createState() => _DeliveringScreenState();
}

class _DeliveringScreenState extends State<DeliveringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Yetkazilmoqda',
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
            leading: Icon(Icons.local_shipping),
            title: Text('Order #12345'),
            subtitle: Text('Delivery Address: 123 Main St, City, Country'),
            trailing: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.location_fill,color: Colors.teal,size: 35,)),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text('Order #67890'),
            subtitle: Text('Delivery Address: 456 Elm St, City, Country'),
            trailing: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.location_fill,color: Colors.teal,size: 35,)),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
