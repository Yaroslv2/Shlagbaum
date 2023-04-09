import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shlagbaum/application/bloc/home_page/home_page_bloc.dart';
import 'package:shlagbaum/application/service/home_page_sevice.dart';

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
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state.state == homeState.sussess) {
              return const HomePageSussess();
            }
            if (state.state == homeState.error) {
              return const HomePageError();
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
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

    Widget listViewBuilder() {
      if (bloc.state.numbers.isEmpty) {
        return const Center(
          child: Text("Тут пусто..."),
        );
      } else {
        return ListView.builder(
          itemCount: bloc.state.numbers.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bloc.state.numbers[index].number,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomePageBloc>(context)
              .add(HomePageEvent.lodingPage());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: listViewBuilder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class HomePageError extends StatelessWidget {
  const HomePageError({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
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
