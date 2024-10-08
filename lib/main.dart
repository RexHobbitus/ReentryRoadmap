// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:reentry_roadmap/presentation/auth_bloc.dart';
// import 'package:reentry_roadmap/presentation/pages/login_signup.dart';
// import 'injection_container.dart' as di;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   di.init(); // Initialize dependency injection
//   runApp(App());
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => di.sl<AuthCubit>()..checkCurrentUser(),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Firebase Clean Architecture App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: AuthPage(), // Initial page
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reentry_roadmap/data/repositories/database/onboarding_assesment_imp.dart';
import 'package:reentry_roadmap/domain/usecases/onboarding_submit_usercase.dart';
import 'package:reentry_roadmap/presentation/onboarding_provider.dart';
import 'package:reentry_roadmap/presentation/view_questions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AssessmentProvider(
            SubmitOnboardingUseCase(
              AssessmentRepositoryImpl(
                FirebaseFirestore.instance,FirebaseAuth.instance
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Assessment App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: QuestionFormScreen(sectionIndex: 0),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionFormScreen(sectionIndex: 0)),
      );
    } catch (e) {
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            if (isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
          ],
        ),
      ),
    );
  }
}
