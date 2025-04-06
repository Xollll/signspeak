import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signspeak/dashboard/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
    print("Form validation failed or _formKey is null.");
    return;
  }
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("Login successful! User: ${userCredential.user?.email}");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful!")));

      // TODO: Navigate to Home Screen after successful login

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ), 
      );
    } on FirebaseAuthException catch (e) {
      String message = "No user data found.";
      if (e.code == 'user-not-found') {
        message = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(20),
              elevation: 8, // Add shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), 
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min, 
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset('assets/images/loginIcon.png', height: 100),
                    SizedBox(height: 20),
                    Text(
                      "Welcome to SignSpeak",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Username Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          // Login Button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 10,
                              ),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                            child:
                                _isLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text("Login"),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Text("Or", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
