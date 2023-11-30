import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/firebase/FirebaseService.dart';
import 'package:test1/pages/homePage.dart';
import 'package:test1/pages/loadingScreen.dart';
import 'package:test1/utils/WidgetVoid.dart';
import 'package:test1/widget/reUseTextForm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // user
  late User user;

  late bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2B5876),
          Color(0xff4E4376),
        ])),
        child: Stack(
          children: [
            textForm(context),
            if (isLoading) const LoadingScreen(),
          ],
        ),
      ),
    );
  }

  Form textForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // username
            ReUseTextForm(
              textController: _usernameController,
              textLabel: "Username",
              isHidingText: false,
              inputName: "username",
            ),

            const SizedBox(
              height: 20,
            ),

            // email
            ReUseTextForm(
              textController: _emailController,
              textLabel: "Email",
              isHidingText: false,
              inputName: "email",
            ),

            const SizedBox(
              height: 20,
            ),

            // password
            ReUseTextForm(
              textController: _passwordController,
              textLabel: "Password",
              isHidingText: true,
              inputName: "password",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  // register
                  await FirebaseService.signUpWithEmailAndPassword(
                    _emailController.text,
                    _passwordController.text,
                    userName: _usernameController.text,
                  ).then(
                    (_) async {
                      user = _auth.currentUser!;
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            user: user,
                          ),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ).catchError(
                    (error) {
                      setState(() {
                        isLoading = false;
                      });
                      WidgetVoid.showSnackBar(context, "Loi Dang Ky");
                      print(error.toString());
                    },
                  );
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
