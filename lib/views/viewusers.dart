import 'package:crud_app/json_models/users_model.dart';
import 'package:crud_app/sqlite/db_conn.dart';
import 'package:crud_app/views/updateform.dart';
import 'package:flutter/material.dart';

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
  late DatabaseHelper handler;
  late Future<List<Users>> usersList;
  final dB = DatabaseHelper();

  @override
  void initState() {
    handler = DatabaseHelper();
    usersList = handler.getAllUsers();
    handler.initDB().whenComplete(() {
      usersList = handler.getAllUsers();
    });
    super.initState();
  }

  Future<List<Users>> allUserData() {
    return handler.getAllUsers();
  }

  Future<void> _refresh() async {
    setState(() {
      usersList = allUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<List<Users>>(
          future: usersList,
          builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text("No data"));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final everyUsersData = snapshot.data ?? <Users>[];
              return ListView.builder(
                itemCount: everyUsersData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(everyUsersData[index].email),
                          Text(everyUsersData[index].mobileNumber),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              bool updateResult = await showDialog(
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    body: UpdateScreen(
                                        userData: everyUsersData[index]),
                                  );
                                },
                              );

                              if (updateResult == true) {
                                // If the result is true, refresh the data
                                _refresh();
                              }
                            },
                          ),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              dB
                                  .deleteUser(everyUsersData[index].id!)
                                  .whenComplete(() {
                                _refresh();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
