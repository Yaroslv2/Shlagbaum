import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/service/authefication_service.dart';
import 'theme.dart';
import 'package:shlagbaum/presentation/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: Authefication(),
    );
  }
}

class Authefication extends StatelessWidget {
  const Authefication({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthService(),
      child: BlocProvider<AuthBloc>(
        create: (context) {
          return AuthBloc(RepositoryProvider.of<AuthService>(context))
            ..add(AuthEvent.loadingApp());
        },
        child: Scaffold(
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                SnackBar snackbar;
                if (state.message != null) {
                  snackbar = SnackBar(
                    content: Text(state.message!),
                    backgroundColor: Colors.red[200],
                  );
                } else {
                  snackbar = SnackBar(
                    content:
                        const Text("Непредвиденная ошибка, попробуйте снова"),
                    backgroundColor: Colors.red[200],
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                BlocProvider.of<AuthBloc>(context).emit(UserNotAutheficated());
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is UserAutheficated) {
                  return const BottomBar();
                }
                if (state is UserNotAutheficated) {
                  return const PreLoginPage();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
