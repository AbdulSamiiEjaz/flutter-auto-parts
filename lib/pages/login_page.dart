import 'package:fzc_global_app/components/text_input.dart';
import 'package:fzc_global_app/screens/splash_screen.dart';
import 'package:fzc_global_app/utils/constants.dart';
import 'package:fzc_global_app/utils/secure_storage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onSubmit() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (emailController.text == "admin" &&
          passwordController.text == "flutter") {
        SecureStorage secureStorage = SecureStorage();
        secureStorage.writeSecureData(SecureStorageKeys.userId, "1");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomSplashScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("FZC Parts",
                  style: TextStyle(
                    fontSize: 28,
                  )),
              const SizedBox(
                height: 30,
              ),
              TextInput(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              TextInput(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: onSubmit,
                    label: const Text("Login"),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Constants.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
