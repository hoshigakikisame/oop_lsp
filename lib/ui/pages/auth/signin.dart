import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obsecure = true;

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
                      'Sign In',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please sign in to continue',
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
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final String email = _emailController.text;
                            final String password = _passwordController.text;
                            final AuthProvider authProvider = context.read();
                            await authProvider.signIn(
                                email: email, password: password);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Sign In'),
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
                  const Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'signup');
                      },
                      child: Text('Sign Up',
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
