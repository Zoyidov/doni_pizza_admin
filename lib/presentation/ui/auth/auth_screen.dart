import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_bloc.dart';
import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_event.dart';
import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_state.dart';
import 'package:doni_pizza_admin/presentation/utils/icons.dart';
import 'package:doni_pizza_admin/presentation/utils/snackbar_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppImages.log,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Doni Pizza Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.white
                          )
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(GoogleLoginEvent());
                        },
                        label: const Text(
                          ' Login',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Sora', fontSize: 20),
                        ),
                        icon: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                          if (state.signInWithGoogleStatus == Status.loading) {
                            return const SizedBox.square(
                                child: CircularProgressIndicator(color: Colors.white));
                          }
                          return SvgPicture.asset(AppImages.google);
                        }, listener: (BuildContext context, AuthState state) {
                          if (state.error != null) {
                            TDialog.showAlert(context: context, message: state.error!);
                          }
                        }),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
