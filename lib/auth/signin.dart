import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/blocks/auth_block.dart';
import 'package:flutter_ecommerce_ui_kit/models/user.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final UserCredential userCredential =
      UserCredential(usernameOrEmail: '', password: '');
  bool showPasswordField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg', // Ensure you have this image in your assets folder
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Dark overlay
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (!showPasswordField)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            userCredential.usernameOrEmail = value!;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    if (showPasswordField)
                      Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/user.png'),
                                radius: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                userCredential.usernameOrEmail,
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              Icon(Icons.check_circle, color: Colors.green),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                userCredential.password = value!;
                              });
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Consumer<AuthBlock>(
                        builder: (context, auth, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              showPasswordField ? 'Continue' : 'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (showPasswordField) {
                                  auth.login(userCredential);
                                } else {
                                  setState(() {
                                    showPasswordField = true;
                                  });
                                }
                              }
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    if (!showPasswordField)
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot password?',
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 10),
                          Text('Or', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                            icon: Image.asset('assets/google.png', height: 24),
                            label: Text('Login with Google'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(height: 10),
                          ElevatedButton.icon(
                            icon: Icon(Icons.apple, color: Colors.white),
                            label: Text('Login with Apple'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {},
                            child: Text('Don’t have an account? Sign up',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

      