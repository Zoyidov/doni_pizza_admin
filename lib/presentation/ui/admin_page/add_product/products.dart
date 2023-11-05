import 'package:doni_pizza_admin/business_logic/food_bloc/food_bloc.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/state_bloc.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_product/add_product.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/edit/edit_product.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global%20dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/icons.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> items = [
    'Pizza Peperoni',
    'Lavash Sirli',
    'CheeseBurger',
    'Coca Cola',
    'Xagi Tovuqli',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Maxsulotlar',
            style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body:
      BlocBuilder<FoodBlocRemote, FoodStateRemote>(
        builder: (context, state) {
          print("state is $state");
          if (state is FetchFoodSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.food.length,
                    itemBuilder: (context, index) {
                      final item = state.food[index];
                      return ListTile(
                        onTap: () {},
                        title: Text(item.name),
                        leading: Image.asset(
                          item.imageUrl,
                          width: 80,
                          height: 80,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProduct()));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                GlobalDialog.show(
                                  context: context,
                                  title: 'O\'chirish',
                                  message: 'Haqiqatdan ham o\'chirmoqchimisiz?',
                                  buttonYes: 'Ha',
                                  buttonNo: 'Yo\'q',
                                  onYesPressed: () {},
                                  onNoPressed: () {},
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is FetchFoodLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchFoodFailure) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Unknown state: $state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addProduct',
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
