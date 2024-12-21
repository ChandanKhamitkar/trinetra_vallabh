import 'package:flutter/material.dart';
import 'package:trinetra_vallabh/UI/screens/details/personaldetails.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PersonalDetailsPage(),
                      ),
                    );
                  },
                  child: Text("Login with Google"),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
