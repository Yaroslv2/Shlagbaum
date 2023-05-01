import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/presentation/pages.dart';

class PreLoginPage extends StatelessWidget {
  const PreLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 7,
                child: Center(
                  child: Text(
                    "Shlagbaum",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoginPage(
                                      bloc:
                                          BlocProvider.of<AuthBloc>(context))));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Вход",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
