import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/bloc/login_page/login_page_cubit.dart';

class RegistrationControllers {
  final key = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final carNumberController = TextEditingController();
}

final registrationControllers = RegistrationControllers();

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<LoginPageCubit>(context).GoBack();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "Регистрация",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Flexible(
                flex: 4,
                child: _RegistrationForm(),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (registrationControllers.key.currentState!
                              .validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              AuthEvent.registration(
                                name:
                                    registrationControllers.nameController.text,
                                lastname: registrationControllers
                                    .lastnameController.text,
                                phoneNumber: registrationControllers
                                    .phoneNumberController.text,
                                password: registrationControllers
                                    .passwordController.text,
                                carNumber: registrationControllers
                                    .carNumberController.text,
                              ),
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
                          "Зарегистрироваться",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<LoginPageCubit>(context)
                            .GoToLoginPage();
                      },
                      child: Text(
                        "Уже есть аккаунт?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
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

class _RegistrationForm extends StatefulWidget {
  const _RegistrationForm();

  @override
  State<_RegistrationForm> createState() => __RegistrationFormState();
}

class __RegistrationFormState extends State<_RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: registrationControllers.key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: registrationControllers.phoneNumberController,
            cursorColor: Colors.black,
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
                return "Некорректный номер телефона";
              }
              return null;
            },
          ),
          TextFormField(
            controller: registrationControllers.nameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Имя",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.account_circle_rounded,
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
              if (value == null || value.isEmpty) {
                return "Пожалуйста, заполните это поле";
              }
              return null;
            },
          ),
          TextFormField(
            controller: registrationControllers.lastnameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Фамилия",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.account_circle_rounded,
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
              if (value == null || value.isEmpty) {
                return "Пожалуйста, заполните это поле";
              }
              return null;
            },
          ),
          TextFormField(
            controller: registrationControllers.carNumberController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Номер машины",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.directions_car_sharp,
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
              if (value == null || value.isEmpty) {
                return "Пожалуйста, заполните это поле";
              }
              return null;
            },
          ),
          TextFormField(
            controller: registrationControllers.passwordController,
            cursorColor: Colors.black,
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
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 8) {
                return "Некорректный пароль";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
