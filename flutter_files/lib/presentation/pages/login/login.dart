import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loginTabActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            children: [
              Container(
                constraints:
                    const BoxConstraints(maxHeight: 450, maxWidth: 200),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _loginTabActive,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.green.shade300,
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _loginTabActive = true;
                                        });
                                      },
                                      child: const Text('Login')),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.green.shade100,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _loginTabActive = false;
                                      });
                                    },
                                    child: const Text('Sign up'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Login'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black87,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.translate_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black87,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.apple_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !_loginTabActive,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.green.shade100,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _loginTabActive = true;
                                      });
                                    },
                                    child: const Text('Login'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    color: Colors.green.shade300,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _loginTabActive = false;
                                      });
                                    },
                                    child: const Text('Sign up'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const TextField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Sign up'),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black87,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.translate_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: const BoxDecoration(
                                    color: Colors.black87,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.apple_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
