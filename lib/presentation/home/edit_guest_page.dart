import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/edit_guest/edit_guest_cubit.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/models/car_number.dart';
import 'package:shlagbaum/presentation/home/add_guest_page.dart';

class EditGuestPage extends StatelessWidget {
  GuestCarNumber guest;
  final bloc;
  EditGuestPage({super.key, required this.guest, required this.bloc});

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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: BlocProvider(
          create: (context) => EditGuestCubit(),
          child: Center(child: EditForm(guest: guest, bloc: bloc)),
        ),
      ),
    );
  }
}

class EditForm extends StatefulWidget {
  GuestCarNumber guest;
  final bloc;
  EditForm({super.key, required this.guest, required this.bloc});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final keyForm = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final carNumberController = TextEditingController();
  var oneVizit;

  @override
  initState() {
    super.initState();
    nameController.text = widget.guest.guestName;
    carNumberController.text = widget.guest.number;
    oneVizit = widget.guest.oneTime;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyForm,
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
                if (value == null || value.isEmpty || value.length < 7) {
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
            BlocProvider(
              create: (context) => EditGuestCubit(),
              child: BlocListener<EditGuestCubit, EditGuestState>(
                listener: (context, state) {
                  if (state is EditGuestSuccess) {
                    Navigator.pop(context);
                    widget.bloc.add(HomePageEvent.lodingPage());
                  }
                  if (state is EditGuestFailure) {
                    SnackBar snackbar = SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red[200],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<EditGuestCubit, EditGuestState>(
                    builder: (context, state) {
                      if (state is EditGuestLoading) {
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
                            BlocProvider.of<EditGuestCubit>(context).edit(
                              widget.guest.id,
                              nameController.text,
                              carNumberController.text,
                              oneVizit,
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
      ),
    );
  }
}
