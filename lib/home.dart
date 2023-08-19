import '../model/user.dart';
import '../service/user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Bloc app'),
        ),
        body: blocBody(),
      ),
    );
  }
}

Widget blocBody() {
  return BlocProvider(
    create: (context) => UserBloc(UserRepository())..add(LoadUserEvent()),
    child: BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoadedState) {
          List<Users> users = state.users;
          return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        users[index].username.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        users[index].email,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              });
        }
        return Container();
      },
    ),
  );
}
