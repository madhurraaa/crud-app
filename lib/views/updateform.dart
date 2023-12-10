import 'package:crud_app/json_models/users_model.dart';
import 'package:crud_app/sqlite/db_conn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateScreen extends StatefulWidget {
  final Users userData;

  const UpdateScreen({Key? key, required this.userData}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final mobileNumController = TextEditingController();
  final emailController = TextEditingController();
  final dateinputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();

    mobileNumController.text = widget.userData.mobileNumber;
    emailController.text = widget.userData.email;
    dateinputController.text = widget.userData.dob;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 255, 78, 90).withOpacity(0.9),
                      ),
                      child: TextFormField(
                        controller: mobileNumController,
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
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 255, 78, 90).withOpacity(0.9),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          icon: Icon(Icons.person_2_rounded),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 255, 78, 90).withOpacity(0.9),
                      ),
                      child: Center(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'DOB';
                            }
                            return null;
                          },
                          controller: dateinputController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.calendar_today),
                            labelText: "DOB",
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                dateinputController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 56, 90, 101),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Create a new Users object with updated values
                          Users updatedUserData = Users(
                            id: widget.userData.id,
                            mobileNumber: mobileNumController.text,
                            email: emailController.text,
                            password: widget.userData.password, // Password remains unchanged
                            dob: dateinputController.text,
                          );

                          // Update user data
                          db.updateUser(updatedUserData).then((_) {
                            Navigator.pop(context, true);
                          });
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}