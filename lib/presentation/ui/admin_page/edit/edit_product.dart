import 'package:doni_pizza_admin/presentation/ui/widgets/global_textfield.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Yangilash',
          style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              GlobalTextField(
                hintText: 'Maxsulotning yangi nomi',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              SizedBox(
                height: 10.0,
              ),
              GlobalTextField(
                hintText: 'Maxsulotning yangi ma\'lumoti',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              SizedBox(
                height: 10.0,
              ),
              GlobalTextField(
                hintText: 'Maxsulotning yangi narxi',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                caption: '',
              ),
              SizedBox(height: 100,),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    side: BorderSide(
                      width: 2,
                    )),
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Yangilash',
                    style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
