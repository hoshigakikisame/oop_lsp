import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  bool obsecure = true;
  bool obsecure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(context.isLightMode
                  ? CupertinoIcons.moon
                  : CupertinoIcons.brightness),
              onPressed: () {
                final ConfigProvider provider = context.read();
                provider.toggleThemeMode();
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          foregroundColor: context.accentColor),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Account',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Create an account to continue',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.mail),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _passwordController,
                        obscureText: obsecure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(CupertinoIcons.padlock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => obsecure = !obsecure);
                            },
                            child: Icon(obsecure
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _passwordController2,
                        obscureText: obsecure2,
                        decoration: InputDecoration(
                          labelText: 'Repeat Password',
                          prefixIcon: const Icon(CupertinoIcons.padlock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => obsecure2 = !obsecure2);
                            },
                            child: Icon(obsecure2
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                          ),
                        )),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final String email = _emailController.text;
                            final String password = _passwordController.text;
                            final String password2 = _passwordController2.text;

                            if (password != password2) {
                              scaffoldMessengerKey.currentState?.showSnackBar(
                                snackbar(
                                  scaffoldMessengerKey.currentContext!,
                                  backgroundColor: Colors.red,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Flexible(
                                            child: Text(
                                          'Password mismatch',
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              return;
                            }
                            final AuthProvider authProvider = context.read();
                            await authProvider.signUp(
                                email: email, password: password);
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Sign Up'),
                              SizedBox(width: 8),
                              Icon(CupertinoIcons.chevron_compact_right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have a account?',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Sign In',
                          style: TextStyle(color: context.accentColor))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
