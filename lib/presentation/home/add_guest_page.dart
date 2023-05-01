import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/add_guest/add_guest_cubit.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/application/service/server_info.dart';

class AddNewGuest extends StatelessWidget {
  final bloc;
  const AddNewGuest({super.key, required this.bloc});

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
        title: Text(
          "Добавление гостя",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Center(child: GuestForm(bloc: bloc)),
      ),
    );
  }
}

class GuestForm extends StatefulWidget {
  final bloc;
  const GuestForm({super.key, required this.bloc});

  @override
  State<GuestForm> createState() => _GuestFormState();
}

class _GuestFormState extends State<GuestForm> {
  final nameController = TextEditingController();
  final carNumberController = TextEditingController();
  var oneVizit = true;
  final keyForm = GlobalKey<FormState>();
  String _dropDownValue = "Легковой";

  List<String> _dropItems = ["Легковой", "Грузовой"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
      child: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2)),
          TextFormField(
            controller: nameController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              label: Text(
                "Имя гостя",
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
            controller: carNumberController,
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
              if (value == null || value.isEmpty || value.length < 7) {
                return "Некорректный номер машины";
              }
              return null;
            },
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Text(
            "Тип автомобиля",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          DropdownButton(
            hint: _dropDownValue == null
                ? Text(
                    _dropItems[0],
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : Text(
                    _dropDownValue,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
            items: _dropItems
                .map((val) => DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )))
                .toList(),
            isExpanded: true,
            iconSize: 30,
            elevation: 0,
            onChanged: (val) {
              setState(() {
                _dropDownValue = val!;
              });
            },
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Одноразовый",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Switch(
                value: oneVizit,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    oneVizit = value;
                  });
                },
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
          ),
          BlocProvider(
            create: (context) => AddGuestCubit(),
            child: BlocListener<AddGuestCubit, AddGuestState>(
              listener: (context, state) {
                if (state is AddGuestSuccess) {
                  Navigator.pop(context);
                  widget.bloc.add(HomePageEvent.lodingPage());
                }
                if (state is AddGuestFailure) {
                  SnackBar snackbar = SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red[200],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<AddGuestCubit, AddGuestState>(
                  builder: (context, state) {
                    if (state is AddGuestLoading) {
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
                        if (keyForm.currentState!.validate()) {
                          BlocProvider.of<AddGuestCubit>(context).add(
                            nameController.text,
                            carNumberController.text,
                            oneVizit,
                            _dropDownValue,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Text(
                        "Добавить",
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
