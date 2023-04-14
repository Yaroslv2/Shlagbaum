import 'package:flutter/material.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/application/service/server_info.dart';

// class GuestFormControllers {
//   final nameController = TextEditingController();
// }

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

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
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
                if (value == null || value.isEmpty || value.length != 7) {
                  return "Некорректный номер машины";
                }
                return null;
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.bloc.add(HomePageEvent.lodingPage());
                },
                child: Text(
                  "Добавить",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
