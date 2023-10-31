// ignore_for_file: library_private_types_in_public_api

import 'package:doni_pizza_admin/presentation/ui/admin_page/add_category/categories.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_promotion/promotions.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/add_product/products.dart';
import 'package:doni_pizza_admin/presentation/ui/admin_page/log_out/log_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../../business_logic/cubit/tab_cubit.dart';


class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  _TabBoxAdminState createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {

  List<Widget> pages = [
    const ProductScreen(),
    const Categories(),
    const Promotions(),
    const LogOut(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: context
                .watch<TabCubit>()
                .state,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizotnal,
          bubbleFillStyle: BubbleFillStyle.fill,
          opacity: 0.5,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.all_out),
            title: const Text('Maxsulotlar'),
            backgroundColor: Colors.black,
            selectedIcon: const Icon(Icons.edit_off_sharp),
          ),
          BottomBarItem(
            icon: const Icon(Icons.label_important),
            title: const Text('Categoriya'),
            backgroundColor: Colors.black,
            selectedIcon: const Icon(Icons.new_label_rounded),

          ),
          BottomBarItem(
            icon: const Icon(CupertinoIcons.news),
            title: const Text('Yangiliklar'),
            backgroundColor: Colors.black,
            selectedIcon: const Icon(Icons.add_moderator),
          ),
          BottomBarItem(
            icon: const Icon(Icons.logout),
            title: const Text('Chiqish'),
            backgroundColor: Colors.red,
          ),
        ],
        hasNotch: true,
        currentIndex: context
            .watch<TabCubit>()
            .state,
        onTap: context
            .read<TabCubit>()
            .changeTab,
      )
    );
  }
}