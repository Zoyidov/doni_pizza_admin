import 'package:doni_pizza_admin/presentation/ui/admin_page/tab_box/tab_box_admin.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: ShapeBorder.lerp(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      0.5,
                    ),
                    title: Text(
                      'Log Out',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: Text('Admin profiliga  o\'tmoqchimisiz?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yo\'q',
                          style: TextStyle(color: Colors.black, fontFamily: 'Sora'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TabBoxAdmin()));
                        },
                        child: Text(
                          'Ha',
                          style: TextStyle(color: Colors.red, fontFamily: 'Sora'),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.compare_arrows),
            color: Colors.red,
          )
        ]
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
