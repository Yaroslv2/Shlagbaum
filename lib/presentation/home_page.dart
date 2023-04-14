import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/auth/auth_bloc.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/application/service/home_page_sevice.dart';
import 'package:shlagbaum/presentation/add_guest_page.dart';
import 'package:shlagbaum/presentation/edit_guest_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomePageService(),
      child: BlocProvider(
        create: (context) => HomePageBloc(
          RepositoryProvider.of<HomePageService>(context),
        )..add(HomePageEvent.lodingPage()),
        child: BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {
            if (state.state == homeState.errorMessage) {
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
          child: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state.needRefresh == true) {
                state.needRefresh = false;
                return HomePageSussess();
              }
              if (state.state == homeState.sussess) {
                return const HomePageSussess();
              }
              if (state.state == homeState.error) {
                return const HomePageError();
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HomePageSussess extends StatelessWidget {
  const HomePageSussess({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);

    return RefreshIndicator(
      displacement: 50,
      strokeWidth: 2,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        BlocProvider.of<HomePageBloc>(context).add(HomePageEvent.lodingPage());
      },
      backgroundColor: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Гостевые номера",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: ListViewBuild(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((_) => AddNewGuest(
                      bloc: BlocProvider.of<HomePageBloc>(context),
                    )),
              ),
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ListViewBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);
    if (bloc.state.numbers.isEmpty) {
      return Center(
        child: Text("Тут пусто..."),
      );
    } else {
      return ListView.separated(
        itemCount: bloc.state.numbers.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bloc.state.numbers[index].guestName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18),
                    ),
                    Text(
                      bloc.state.numbers[index].number,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      bloc.state.numbers[index].oneTime
                          ? "Одноразовый"
                          : "Постоянный",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditGuestPage(
                          index: index,
                          guest: bloc.state.numbers[index],
                          bloc: BlocProvider.of<HomePageBloc>(context),
                        ),
                      ));
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<HomePageBloc>(context)
                        .add(HomePageEvent.deleteGuest(guestIndex: index));
                  },
                  icon: Icon(Icons.delete_forever_outlined)),
            ],
          );
        },
      );
    }
  }
}

class HomePageError extends StatelessWidget {
  const HomePageError({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        displacement: 50,
        strokeWidth: 2,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          bloc.add(HomePageEvent.lodingPage());
        },
        child: Center(
          child: Text(
            bloc.state.errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
