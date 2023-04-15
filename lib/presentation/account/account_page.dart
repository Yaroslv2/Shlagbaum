import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/account_page/account_page_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/service/account_page_service.dart';
import 'package:shlagbaum/presentation/account/change_password_page.dart';
import 'package:shlagbaum/presentation/account/edit_account_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Аккаунт",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 24),
        ),
      ),
      body: RepositoryProvider(
        create: (context) => AccountPageService(),
        child: BlocProvider(
          create: (context) => AccountPageBloc(
              BlocProvider.of<AuthBloc>(context),
              RepositoryProvider.of<AccountPageService>(context))
            ..add(AccountPageEvent.loadingPage()),
          child: BlocListener<AccountPageBloc, AccountPageState>(
            listener: (context, state) {
              if (state.state == accountState.errorMessage) {
                SnackBar snackBar;
                if (state.errorMessage != null) {
                  snackBar = SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  );
                } else {
                  snackBar = const SnackBar(
                    content: Text("Непредвиденная ошибка, попробуйте позже"),
                    backgroundColor: Colors.red,
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: BlocBuilder<AccountPageBloc, AccountPageState>(
              builder: (context, state) {
                if (state.needRefresh == true) {
                  state.needRefresh = false;
                  return AccountPageSuccess();
                }
                if (state.state == accountState.sussess) {
                  return AccountPageSuccess();
                }
                if (state.state == accountState.error) {
                  return AccountPageError();
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AccountPageSuccess extends StatelessWidget {
  const AccountPageSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountPageBloc>(context);

    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(AccountPageEvent.loadingPage());
      },
      backgroundColor: Colors.black,
      color: Colors.white,
      displacement: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.grey[350],
                  size: MediaQuery.of(context).size.width * 0.2,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                Text(
                  "${bloc.state.name}\n${bloc.state.lastname}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 24),
                ),
              ],
            ),
            Text(
              "Номер машины: ${bloc.state.carNumber}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.5),
            ),
            Divider(),
            InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditAccountInfoPage(
                            bloc: bloc,
                          )),
                );
              },
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              child: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Text(
                      "Изменить информацию",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkResponse(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordPage()));
              },
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              child: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.key_outlined,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Text(
                      "Изменить пароль",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkResponse(
              onTap: () {
                BlocProvider.of<AccountPageBloc>(context)
                    .add(AccountPageEvent.logout());
              },
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              child: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.sensor_door_outlined,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Text(
                      "Выйти",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkResponse(
              onTap: () => BuildDialog(context, bloc),
              containedInkWell: true,
              highlightShape: BoxShape.rectangle,
              child: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.block_outlined,
                      color: Colors.red[900],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Text(
                      "Удалить аккаунт",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.red[900]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPageError extends StatelessWidget {
  const AccountPageError({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountPageBloc>(context);
    return RefreshIndicator(
      child: ListView(
        children: [
          Text("${bloc.state.errorMessage}"),
        ],
      ),
      onRefresh: () async {},
    );
  }
}

Future<void> BuildDialog(context, bloc) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Удаление аккаунта",
        style:
            Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
      content: Text(
        "Вы уверены? Удаление приведет к удалению всех данных, восстановление аккаунта не будет возможным.",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "НЕТ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextButton(
          onPressed: () {
            bloc.add(AccountPageEvent.deleteAccount());
            Navigator.pop(context);
          },
          child: Text(
            "ДА",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}
