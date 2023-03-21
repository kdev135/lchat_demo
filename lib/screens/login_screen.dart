import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lchat/operations/services/email_password_auth.dart';

import '../models/ui_models/text_field_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/lchat.png'),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Text('Please enter your credentials to proceed'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                            ),
                            TextFieldModel(textController: emailController,),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                            ),
                            TextFieldModel(
                              textController: passwordController,
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          emailPasswordAuth(
                              email: emailController.text, password: passwordController.text, context: context);
                        },
                        child: const Text('Login'),
                      ),
                    )
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


