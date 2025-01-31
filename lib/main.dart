// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trinetra_vallabh/UI/screens/home_screen.dart';
import 'package:trinetra_vallabh/UI/screens/onboarding/onboarding_page.dart';
import 'dart:async';
import 'firebase_options.dart';
import './utils/user_auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(ChangeNotifierProvider(
    create: (context) => UserAuthProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vallabh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyHomePage();
          }

          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, firestoreSnapshot) {
                if (firestoreSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const MyHomePage();
                }
                if (firestoreSnapshot.hasData &&
                    firestoreSnapshot.data!.exists) {
                  final userData =
                      firestoreSnapshot.data!.data() as Map<String, dynamic>;
                  if (userData['isProfileCompleted'] == true) {
                    print('snapshot data = ${snapshot.data!}');
                    final userAuthProvider =
                        Provider.of<UserAuthProvider>(context, listen: false);
                    userAuthProvider.setUser(snapshot.data);
                    return const HomeScreenPage();
                  } else {
                    return OnboardingPage();
                    // return HomeScreenPage();
                  }
                } else {
                  return OnboardingPage();
                  // return HomeScreenPage();
                }
              },
            );
          } else {
            return OnboardingPage();
            // return HomeScreenPage();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 3), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => OnboardingPage()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/brand-name.png", width: 262, height: 88),
              SizedBox(height: 24),
              const LinearProgressIndicator(),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: 0,
                      // -- flutter_svg --
                      child: Image.asset("images/Ellipse-one.png",
                          width: 894, height: 200),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset("images/av-one.png",
                          width: 424, height: 406),
                    ),
                    // Positioned(
                    //   bottom: 25,
                    //   child: Text(
                    //     'the ananta initiative',
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyLarge
                    //         ?.copyWith(color: const Color(0xffCAC4D0)),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
