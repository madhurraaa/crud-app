import 'package:crud_app/json_models/users_model.dart';
import 'package:crud_app/sqlite/db_conn.dart';
import 'package:crud_app/views/bottomnavbar.dart';
import 'package:crud_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //text editing controller for text fields
  final mobileNum = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final dateinput = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 57, 66)),
                  ),
                  // Mobile
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
                          controller: mobileNum,
                          decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            border: InputBorder.none,
                            icon: Icon(Icons.phone_android),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          }),
                    ),
                  ),

                  // Email
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

                  // Password
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

                  // Confirm password
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
                          controller: confirmPassword,
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
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
                              return 'Please re-enter your password';
                            } else if (password.text != confirmPassword.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          }),
                    ),
                  ),

                  // Date of Birth
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 78, 90)
                              .withOpacity(0.9)),
                      child: Center(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your DOB';
                            }
                            return null;
                          },
                          controller: dateinput,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.calendar_today),
                              labelText: "Enter DOB"),
                          readOnly:
                              true, //set as true, so that the user will not be able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),


                  // Sign Up Button
                  Container(
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 56, 90, 101)),
                      child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              db
                                  .createUser(Users(
                                mobileNumber: mobileNum.text,
                                email: email.text,
                                password: password.text,
                                dob: dateinput.text,
                              ))
                                  .then((_) {
                                // Navigate to the new screen after the user is successfully created
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const BottomNav()),
                                );
                              });
                            }
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),

                  // Login Prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(fontSize: 15)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "LOGIN",
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
