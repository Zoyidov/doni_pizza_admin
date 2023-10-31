import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreparingScreen extends StatefulWidget {
  const PreparingScreen({Key? key}) : super(key: key);

  @override
  State<PreparingScreen> createState() => _PreparingScreenState();
}

class _PreparingScreenState extends State<PreparingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Tayyorlanmoqda',
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
            leading: CupertinoActivityIndicator(color: Colors.black,),
            title: Text('Abdukarim', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Toshkent', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.delivery_dining,color: Colors.teal,size: 35,)),
            onTap: () {
            },
          ),
          ListTile(
            leading:  CupertinoActivityIndicator(color: Colors.black,),
            title: Text('Bobur', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Namangan', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: IconButton.outlined(onPressed: (){}, icon: Icon(Icons.delivery_dining,color: Colors.teal,size: 35,)),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
