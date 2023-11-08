import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_event.dart';
import 'package:doni_pizza_admin/business_logic/auth_bloc/auth_state.dart';
import 'package:doni_pizza_admin/business_logic/repositories/auth_repo.dart';
import 'package:doni_pizza_admin/presentation/utils/formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(const AuthState()) {
    on<LoginEvent>(_signInWithEmailAndPassword);
    on<GoogleLoginEvent>(_signInWithGoogle);
    on<RegisterEvent>(_registerWithEmailAndPassword);
  }

  void _signInWithGoogle(GoogleLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signInWithGoogleStatus: Status.loading));
    try {
      final user = await authRepository.signInWithGoogle();
      emit(state.copyWith(user: user, signInWithGoogleStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), signInWithGoogleStatus: Status.failure));
    }
  }

  void _signInWithEmailAndPassword(LoginEvent event, emit) async {
    emit(state.copyWith(signInWithEmailAndPasswordStatus: Status.loading));
    try {
      final user = await authRepository.signInWithEmailAndPassword(
          TFormatter.convertPhoneNumberToEmail(event.phoneNumber), event.password);
      emit(state.copyWith(user: user, signInWithEmailAndPasswordStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), signInWithEmailAndPasswordStatus: Status.failure));
    }
  }

  void _registerWithEmailAndPassword(RegisterEvent event, emit) async {
    emit(state.copyWith(registerWithEmailAndPasswordStatus: Status.loading));
    try {
      final user = await authRepository.registerWithEmailAndPassword(
          TFormatter.convertPhoneNumberToEmail(event.phoneNumber), event.password);
      emit(state.copyWith(user: user, registerWithEmailAndPasswordStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), registerWithEmailAndPasswordStatus: Status.failure));
    }
  }


}
