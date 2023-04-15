import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/account_page/account_page_bloc.dart';
import 'package:shlagbaum/application/bloc/change_user_info/change_user_info_cubit.dart';
import 'package:shlagbaum/application/service/account_page_service.dart';

class EditAccountInfoPage extends StatelessWidget {
  final bloc;
  const EditAccountInfoPage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Изменить информацию",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: EditAccountInfoForm(
          bloc: bloc,
        ),
      ),
    );
  }
}

class EditAccountInfoForm extends StatefulWidget {
  final bloc;
  EditAccountInfoForm({super.key, required this.bloc});

  @override
  State<EditAccountInfoForm> createState() => _EditAccountInfoFormState();
}

class _EditAccountInfoFormState extends State<EditAccountInfoForm> {
  final _key = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _carNumberController = TextEditingController();

  @override
  initState() {
    super.initState();
    _phoneController.text = widget.bloc.state.phone;
    _nameController.text = widget.bloc.state.name;
    _lastnameController.text = widget.bloc.state.lastname;
    _carNumberController.text = widget.bloc.state.carNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          TextFormField(
            controller: _phoneController,
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
              if (value == null || value.isEmpty) {
                return "Пожалуйста, заполните это поле";
              }
              return null;
            },
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            controller: _nameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Имя",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.account_circle_outlined,
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
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            controller: _lastnameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Фамилия",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              prefixIcon: const Icon(
                Icons.account_circle_outlined,
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
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          TextFormField(
            controller: _carNumberController,
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
          Padding(padding: EdgeInsets.symmetric(vertical: 15)),
          BlocProvider(
            create: (context) => ChangeUserInfoCubit(),
            child: BlocListener<ChangeUserInfoCubit, ChangeUserInfoState>(
              listener: (context, state) {
                if (state is ChangeUserInfoSuccess) {
                  Navigator.pop(context);
                  widget.bloc.add(AccountPageEvent.loadingPage());
                }
                if (state is ChangeUserInfoFailure) {
                  SnackBar snackbar = SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red[200],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<ChangeUserInfoCubit, ChangeUserInfoState>(
                  builder: (context, state) {
                    if (state is ChangeUserInfoLoading) {
                      return ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          BlocProvider.of<ChangeUserInfoCubit>(context).changes(
                            _phoneController.text,
                            _nameController.text,
                            _lastnameController.text,
                            _carNumberController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Text(
                        "Изменить",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}