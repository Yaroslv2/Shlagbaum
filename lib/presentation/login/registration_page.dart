import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            children: [
              Text(
                "Регистрация",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              _RegistrationForm(),
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                      BlocProvider.of<LoginPageCubit>(context).GoToLoginPage();
                    },
                    child: Text(
                      "Уже есть аккаунт?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegistrationForm extends StatefulWidget {
  const _RegistrationForm({super.key});

  @override
  State<_RegistrationForm> createState() => __RegistrationFormState();
}

class __RegistrationFormState extends State<_RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: registrationControllers.key,
      child: Column(
        children: [
          TextFormField(
            controller: registrationControllers.phoneNumberController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Телефон",
                style: Theme.of(context).textTheme.bodySmall,
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
