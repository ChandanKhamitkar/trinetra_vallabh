// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/screens/details/personaldetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:trinetra_vallabh/UI/screens/home_screen.dart';
import '../../../utils/user_auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? _errorMessage;
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          print("user data : = $uid");
          print("Successfully logged in with google!");
          final userAuthProvider =
              Provider.of<UserAuthProvider>(context, listen: false);
          userAuthProvider.setUser(userCredential.user);

          // check if profileCompleted or not
          DocumentSnapshot userDoc =
              await _firestore.collection('users').doc(uid).get();
          if (userDoc.exists && userDoc.get('isProfileCompleted') == true) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreenPage(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PersonalDetailsPage(),
              ),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Unexpected error occurred!";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error in Sing in / Sign up, Please try again!"),
          duration: Duration(seconds: 2),
        ),
      );
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Color(0xFFE8E0FF),
              child: Image.asset("images/namasthe-bhima.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text("join our journey to a healthy life style"),
                SizedBox(
                  height: 24,
                ),
                OutlinedButton(
                  onPressed: () {
                    _signInWithGoogle();
                  },
                  child: Text("Login with Google"),
                ),
                SizedBox(
                  height: 32,
                ),
                // if (_errorMessage != null)
                //   Text(
                //     _errorMessage!,
                //     style: const TextStyle(color: Colors.red),
                //   ),
              ],
            ),
          ),
          // if (_isLoading)
          //   Container(
          //     color: Colors.black.withOpacity(0.5),
          //     child: const Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
