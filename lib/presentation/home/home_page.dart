import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/application/service/home_page_sevice.dart';
import 'package:shlagbaum/application/widgets/scroll_for_animation_controller.dart';
import 'package:shlagbaum/presentation/home/add_guest_page.dart';
import 'package:shlagbaum/presentation/home/edit_guest_page.dart';

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
                return HomePageSussess();
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

class HomePageSussess extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final hideFabAnimationController = useAnimationController(
        duration: kThemeAnimationDuration, initialValue: 1);
    final _scrollController =
        useScrollForAnimationController(hideFabAnimationController);
    final bloc = BlocProvider.of<HomePageBloc>(context);

    return Scaffold(
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
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.black,
        onRefresh: () async {
          bloc.add(HomePageEvent.lodingPage());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: ListViewBuild(
            scrollController: _scrollController,
          ),
        ),
      ),
      floatingActionButton: FadeTransition(
        opacity: hideFabAnimationController,
        child: ScaleTransition(
          scale: hideFabAnimationController,
          child: FloatingActionButton(
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
      ),
    );
  }
}

class ListViewBuild extends StatelessWidget {
  ScrollController scrollController;
  ListViewBuild({required this.scrollController});
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);
    if (bloc.state.numbers.isEmpty) {
      return ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4)),
          Center(child: Text("Тут пусто...")),
        ],
      );
    } else {
      return ListView.separated(
        controller: scrollController,
        itemCount: bloc.state.numbers.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          if (bloc.state.numbers[index].active == "1") {
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
                        bloc.state.numbers[index].carType,
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
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bloc.state.numbers[index].guestName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18, color: Colors.grey),
                      ),
                      Text(
                        bloc.state.numbers[index].number,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        bloc.state.numbers[index].carType,
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
                Text(
                  "ЗАБАНЕН",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditGuestPage(
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
          }
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
