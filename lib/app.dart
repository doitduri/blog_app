import 'package:blog_app/repositories/user_repository/src/firebase_user_repository.dart';
import 'package:blog_app/repositories/user_repository/src/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'home/authentication/authentication_bloc.dart';
import 'home/authentication/authentication_event.dart';

class App extends StatelessWidget {
  App({
    Key? key,
  }) : super(key: key);

  final UserRepository userRepository = FirebaseUserRepository();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: userRepository),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                userRepository: userRepository,
              )..add(AppStarted());
            },
          ),
        ], child: AppView()));
  }
}
