import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reentry_roadmap/presentation/auth_bloc.dart';
import 'package:reentry_roadmap/presentation/pages/login_signup.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  di.init(); // Initialize dependency injection
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthCubit>()..checkCurrentUser(),
        ),
      ],
      child: MaterialApp(
        title: 'Firebase Clean Architecture App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthPage(), // Initial page
      ),
    );
  }
}
