import 'package:crud_app/views/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/woman-working.jpg",
                    height: 310,
                  ),
                    //Email
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 78, 90)
                              .withOpacity(0.9)),
                      child: TextFormField(
                        controller: email,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              icon: Icon(Icons.person_2_rounded),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          }),
                    ),
                  ),
                    //Password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 78, 90)
                              .withOpacity(0.9)),
                      child: TextFormField(
                        controller: password,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                              icon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  // Show/Hide password toggle
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          }),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //Login Button
                  Container(
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 56, 90, 101)),
                      child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const SignUpScreen()));
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
                  //Sign Up Prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(fontSize: 15)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 78, 90),
                                fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            )),
      )),
    );
  }
}
