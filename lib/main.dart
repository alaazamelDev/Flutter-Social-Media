import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_app/futures/presentation/bloc/bloc.dart';
import 'package:flutter_social_app/futures/presentation/pages/home_page.dart';
import 'package:flutter_social_app/futures/presentation/pages/login_page.dart';
import 'package:flutter_social_app/generate_route.dart';
import 'locator_service.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => di.sl<AuthBloc>()..add(AppStartedEvent()),
          ),
          BlocProvider<CredentialBloc>(
            create: (_) => di.sl<CredentialBloc>(),
          ),
          BlocProvider<UserBloc>(
            create: (_) => di.sl<UserBloc>()..add(GetUsersEvent()),
          ),
          BlocProvider<GroupBloc>(
            create: (_) => di.sl<GroupBloc>()..add(GetGroupsEvent()),
          ),
          BlocProvider<ChatBloc>(
            create: (_) => di.sl<ChatBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: OnGenerateRoute.route,
          routes: {
            "/": (context) {
              return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                if (authState is AuthenticatedState) {
                  return HomePage(uid: authState.uid);
                } else {
                  return const LoginPage();
                }
              });
            }
          },
        ));
  }
}
