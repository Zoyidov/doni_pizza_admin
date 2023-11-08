import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_bloc.dart';
import 'package:doni_pizza_admin/business_logic/cubit/category_cubit/category_cubit.dart';
import 'package:doni_pizza_admin/business_logic/cubit/food_cubit/food_cubit.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/state_bloc.dart';
import 'package:doni_pizza_admin/business_logic/order_bloc/order_remote_bloc.dart';
import 'package:doni_pizza_admin/business_logic/repositories/auth_repo.dart';
import 'package:doni_pizza_admin/business_logic/repositories/category_repo.dart';
import 'package:doni_pizza_admin/firebase_options.dart';
import 'package:doni_pizza_admin/presentation/ui/router_app.dart';
import 'package:doni_pizza_admin/presentation/ui/tab_box/tab_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:doni_pizza_admin/business_logic/cubit/auth_cubit.dart';
import 'package:doni_pizza_admin/business_logic/cubit/tab_cubit.dart';
import 'package:doni_pizza_admin/business_logic/food_bloc/food_bloc.dart';
import 'package:doni_pizza_admin/business_logic/model/food_model.g.dart';
import 'package:doni_pizza_admin/business_logic/model/order_item.dart';
import 'package:doni_pizza_admin/business_logic/promotion_bloc/promotion_bloc.dart';
import 'package:doni_pizza_admin/business_logic/repositories/food_repo.dart';
import 'package:doni_pizza_admin/business_logic/repositories/promotion_repo.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FoodItemAdapter());
  await Hive.openBox<OrderItem>('orderItems');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final AuthRepository authRepository = AuthRepository();
   final FoodItemRepository foodItemRepository = FoodItemRepository();
   final CategoryRepository categoryRepository = CategoryRepository();
   final PromotionRepository promotionRepository = PromotionRepository();



   @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
        BlocProvider<OrderRemoteBloc>(create: (context) => OrderRemoteBloc()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<FoodBloc>(create: (context) => FoodBloc()..add(LoadTodosEvent())),
        BlocProvider<PromotionBloc>(
            create: (context) => PromotionBloc(promotionRepository)..add(GetAllPromotions())),
        BlocProvider<FoodBlocRemote>(
            create: (context) => FoodBlocRemote(foodItemRepository)..add(GetAll())),
        BlocProvider<FoodCubit>(create: (context) => FoodCubit(foodItemRepository)),
        BlocProvider<CategoryCubit>(create: (context) => CategoryCubit(categoryRepository)),
        BlocProvider<FoodBlocRemote>(create: (context) => FoodBlocRemote(foodItemRepository)),

    ],
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )),
        debugShowCheckedModeBanner: false,
        home:  const RouterApp(),

      ),
    );
  }
}
