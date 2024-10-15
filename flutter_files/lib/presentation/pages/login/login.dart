import 'package:flutter/material.dart';
import 'package:flutter_files/presentation/theme/pallete.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loginTabActive = true;
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

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
                      child: Form(
                        key: loginFormKey,
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
                                      color: AppPallete.backgroundColor,
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppPallete.borderColor),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _loginTabActive = true;
                                          });
                                        },
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: AppPallete.gradient1),
                                        )),
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
                                      color: AppPallete.backgroundColor,
                                      border: Border.all(
                                          color: AppPallete.borderColor),
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
                            TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email is missing";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is missing";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Login'),
                              ),
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
                    ),
                    Visibility(
                      visible: !_loginTabActive,
                      child: Form(
                        key: signUpFormKey,
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
                                      color: AppPallete.backgroundColor,
                                      border: Border.all(
                                          color: AppPallete.borderColor),
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
                                      color: AppPallete.backgroundColor,
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppPallete.borderColor),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _loginTabActive = false;
                                        });
                                      },
                                      child: const Text('Sign up',
                                          style: TextStyle(
                                              color: AppPallete.gradient1)),
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
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Sign up'),
                              ),
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
