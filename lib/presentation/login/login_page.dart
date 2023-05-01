import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/bloc/login_page/login_page_cubit.dart';

final phoneNumberController = TextEditingController();
final formGlobalKey = GlobalKey<FormState>();
final passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  final bloc;
  LoginPage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
            ),
            Center(
              child: Text(
                "Вход",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
            ),
            _LoginForm(),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
            ),
            BlocProvider(
              create: (context) => LoginPageCubit(),
              child: BlocListener<LoginPageCubit, LoginPageState>(
                listener: (context, state) {
                  if (state is LoginPageSuccess) {
                    Navigator.pop(context);
                    bloc.add(AuthEvent.login());
                  }
                  if (state is LoginPageFailure) {
                    SnackBar snackbar = SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Color.fromARGB(255, 221, 63, 63),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: BlocBuilder<LoginPageCubit, LoginPageState>(
                  builder: (context, state) {
                    if (state is LoginPageLoading) {
                      return SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formGlobalKey.currentState!.validate()) {
                            BlocProvider.of<LoginPageCubit>(context).Login(
                              phoneNumberController.text,
                              passwordController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Войти",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: phoneNumberController,
            //keyboardType: TextInputType.phone,
            // inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly,
            // ],
            decoration: InputDecoration(
              label: Text(
                "Телефон",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 11) {
                return 'Неправильный номер';
              }
              return null;
            },
            cursorColor: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              label: Text(
                "Пароль",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.vpn_key_rounded,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            cursorColor: Colors.black,
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Некорректный пароль';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
