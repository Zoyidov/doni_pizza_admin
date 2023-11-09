import 'package:cached_network_image/cached_network_image.dart';
import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_state.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/food_bloc.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_product/add_product.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/edit/edit_product.dart';
import 'package:doni_pizza_admin/presentation/ui/widgets/global_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
   context.read<FoodBlocRemote>().add(GetAll());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text('Maxsulotlar',
            style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: BlocBuilder<FoodBlocRemote, FoodStateRemote>(
          builder: (context, state) {
        if (state is FetchFoodSuccess) {
          return ListView.builder(
            itemCount: state.food.length,
            itemBuilder: (context, index) {
              final item = state.food[index];
              return ListTile(
                onTap: () {},
                title: Text(item.name),
                leading: SizedBox(
                  width: 80,
                  height: 80,
                  child: CachedNetworkImage(
                     imageUrl: item.imageUrl,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProduct(foodItem: item,)));
                      },
                      icon: const Icon(
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
                          onYesPressed: () {
                            context.read<FoodBlocRemote>().add(DeleteFoodItem(item.id!));
                            Navigator.pop(context);
                          },
                          onNoPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state is FetchFoodLoading) {
          if (kDebugMode) {
            print(Status.loading);
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (state is FetchFoodFailure) {
          if (kDebugMode) {
            print(state.message);
          }
          return Center(child: Text(state.message));
        }
        if (kDebugMode) {
          print('error');
        }

        return Center(child: Text('Unknown state: $state'));
      }),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addProduct',
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AddProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
