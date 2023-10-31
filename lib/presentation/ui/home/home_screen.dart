import 'package:flutter/material.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Buyurtmalar',
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
            leading: Icon(Icons.online_prediction_rounded),
            title: Row(
              children: [
                Text('Abdukarim', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('  786.000 sum', style: TextStyle(color: Colors.amber[800])),
              ],
            ),
            subtitle: Text('+(998) 99-99-99-99'),
            trailing: Text('Toshkent', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    name: 'Abdukarim',
                    phoneNumber: '+(998) 99-99-99-99',
                    location: 'Toshkent',
                    description: 'Cola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC//Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC//Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC//Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC//Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club/KFC/SandwichCola/Club',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.online_prediction_rounded),
            title: Row(
              children: [
                Text('Bobur', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('  56.000 sum', style: TextStyle(color: Colors.amber[800]))
              ],
            ),
            subtitle: Text('+(998) 88-88-88-88'),
            trailing: Text('Namangan', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    name: 'Bobur',
                    phoneNumber: '+(998) 88-88-88-88',
                    location: 'Namangan',
                    description: 'Pizza/Burger/Cofee/CheeseBurger',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
