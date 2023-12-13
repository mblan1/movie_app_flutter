import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test1/api/apiRequest.dart';
import 'package:test1/firebase/FirebaseService.dart';
import 'package:test1/modals/login_method.dart';
import 'package:test1/pages/AuthScreen/email_verify_page.dart';
import 'package:test1/pages/MovieScreen/home_page.dart';
import 'package:test1/widget/loading_screen.dart';
import 'package:test1/pages/AuthScreen/register_page.dart';
import 'package:test1/widget/reUseTextForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late User user;
  late bool isLoading = false;
  late bool isHidePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void showSnackBar(BuildContext context, String message,
      {backgroundColor = Colors.blue}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: backgroundColor,
      ),
    );
  }

  // handle login
  void handleLogin(bool condition, String route,
      {String elseMessage = "missing"}) {
    if (condition) {
      // getHttp().then((data) => print(data.toString()));
      FirebaseService.signInWithGoogle();
    } else {
      showSnackBar(context, elseMessage);
    }
  }

  void handleLoginWithEmail(User user) {
    if (user.emailVerified) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MailVerifyPage(user: user),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2B5876),
          Color(0xff4E4376),
        ])),
        child: Stack(children: [
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  thumbnail(),
                  title(),

                  // Text Field
                  textForm(context),

                  // login media
                  loginMethod(),

                  // register
                  register(context),
                ],
              ),
            ),
          ),

          // loading screen
          if (isLoading) const LoadingScreen(),
        ]),
      ),
    );
  }

  Row register(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account ?",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          child: const Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Image thumbnail() {
    return Image.asset('assets/images/app_thumb.png', width: 200, height: 200);
  }

  Container title() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Hi not Smile',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  SizedBox loginMethod() {
    return SizedBox(
      height: 50,
      width: 168,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 10),
        scrollDirection: Axis.horizontal,
        itemCount: loginMethods.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                icon: SvgPicture.asset(
                  loginMethods[index].icon,
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  handleLogin(
                    loginMethods[index].isActive,
                    loginMethods[index].route,
                    elseMessage:
                        "Tinh nang dang bao tri vui long dang nhap bang phuong thuc khac !",
                  );
                }),
          );
        },
      ),
    );
  }

  Form textForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // mail
            ReUseTextForm(
              textController: _emailController,
              textLabel: "Email",
              isHidingText: false,
              inputName: "email",
            ),

            const SizedBox(height: 20),

            // password
            ReUseTextForm(
              textController: _passwordController,
              textLabel: "Password",
              isHidingText: isHidePassword,
              inputName: "password",
              isShowPasswordBtn: true,
              onTogglePassword: () {
                setState(() {
                  isHidePassword = !isHidePassword;
                });
              },
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    await FirebaseService.signInWithEmailAndPassword(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    ).then((user) {
                      if (user != null) {
                        handleLoginWithEmail(user);
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        showSnackBar(
                          context,
                          "Email or password is incorrect !",
                          backgroundColor: Colors.red,
                        );
                        setState(() {
                          isLoading = false;
                        });
                      }
                    });
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
