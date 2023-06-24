import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest API Call"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final Color color =
                user['gender'] == "male" ? Colors.blue : Colors.green;
            final fname = user['name']['first'];
            final email = user['email'];
            final imageUrl = user['picture']['thumbnail'];
            final lname = user['name']['last'];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(imageUrl),
              ),
              tileColor: color,
              title: Row(
                children: [
                  Text(fname + " "),
                  Text(lname),
                ],
              ),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
        backgroundColor: Colors.white,
        child: const Text(
          "DATA",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void fetchUsers() async {
    print("Fetchusers Called");
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("fetchUsers Completed");
  }
}
