import 'package:oop_lsp/oop_lsp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserEditor extends StatefulWidget {
  final UserProfile? profile;

  const UserEditor({Key? key, this.profile}) : super(key: key);

  @override
  State<UserEditor> createState() => _UserEditorState();
}

class _UserEditorState extends State<UserEditor> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool obsecure = true;

  @override
  initState() {
    _usernameController.text = widget.profile?.username ?? '';
    _emailController.text = widget.profile?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Text(
            widget.profile == null ? 'Create New User' : 'Update User',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
      Expanded(child: buildEditor())
    ]);
  }

  Widget buildEditor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image rounded
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/200/300/?random',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(CupertinoIcons.person),
            labelText: 'Username',
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: _emailController,
          enabled: widget.profile == null,
          readOnly: widget.profile != null,
          decoration: const InputDecoration(
            prefixIcon: Icon(CupertinoIcons.person),
            labelText: 'Email',
          ),
        ),
        if (widget.profile == null) ...[
          const SizedBox(height: 15),
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
                  child: Icon(
                      obsecure ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
                ),
              )),
        ],
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final String username = _usernameController.text;
                final String password = _passwordController.text;
                final String email = _emailController.text;

                final UserProvider userProvider = context.read();

                if (username.isNotEmpty &&
                    password.isNotEmpty &&
                    email.isNotEmpty) {
                  if (widget.profile == null) {
                    final AuthProvider authProvider = context.read();
                    await authProvider.signUp(
                        email: email, password: password, username: username);
                    await userProvider.refresh();
                    return;
                  }
                  widget.profile!.username = username;

                  await userProvider.updateUser(widget.profile!);
                }
              },
              child: Row(
                children: const [Text('Save')],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
