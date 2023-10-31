import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_bloc.dart';
import 'package:doni_pizza_admin/business_logic/repositories/auth_repo.dart';
import 'package:doni_pizza_admin/firebase_options.dart';
import 'package:doni_pizza_admin/presentation/ui/router_app.dart';
import 'package:doni_pizza_admin/presentation/ui/tab_box/tab_box.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'business_logic/cubit/auth_cubit.dart';
import 'business_logic/cubit/tab_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final AuthRepository authRepository = AuthRepository();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<TabCubit>(
          create: (context) => TabCubit(),
          child: const TabBox(),
        ),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository)),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),

      ],
      child: MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )),
        debugShowCheckedModeBanner: false,
        home:  RouterApp(),
      ),
    );
  }
}
