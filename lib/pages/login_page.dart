import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final Uri apiUrl = Uri(
      scheme: 'https',
      host: 'hisham09.pythonanywhere.com',
      path: '/api/accounts/login',
    );

    final response = await http.post(
      apiUrl,
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('root:toor'))}',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: Text('Success', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            content: Text('You have successfully logged in!', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      String errorMessage;
      try {
        var errorData = jsonDecode(response.body);
        errorMessage = errorData['detail'] ?? 'An error occurred during login.';
      } catch (e) {
        errorMessage = response.body;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(115, 65, 62, 62),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 190, 171, 171),
        title: Text('Login Page', style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _login();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
