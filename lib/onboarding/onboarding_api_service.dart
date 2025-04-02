import 'package:abc/onboarding/bloc/onboarding_bloc.dart';
import 'package:abc/onboarding/bloc/onboarding_event.dart';
import 'package:abc/onboarding/bloc/onboarding_state.dart';
import 'package:abc/onboarding/login_ui.dart';
import 'package:abc/onboarding/logout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: MaterialApp(
        title: 'Flutter BLoC Auth',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
