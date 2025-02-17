import 'package:firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (value) => setState(() {
                  email = value;
                }),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (value) => setState(() {
                  password = value;
                }),
              ),
              ElevatedButton(
                onPressed: createUser,
                child: Text("Create user"),
              ),
              ElevatedButton(onPressed: signIn, child: Text("Login")),
              ElevatedButton(
                onPressed: signOut,
                child: Text("Sign out"),
              ),
              Text('User logged in = ${isSignedIn()}'),
              Text(
                  'User display name = ${FirebaseAuth.instance.currentUser?.displayName}'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createUser() async {
    print("Trying to create a user");
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
    print("done");
  }

  Future<void> signIn() async {
    print("Signing in");
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await credential.user?.updateDisplayName("Username1");
    } catch (e) {
      print(e);
    }
    print("Success");
    setState(() {});
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {});
  }

  bool isSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
