import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // email controller
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        // Username field
        TextFormField(
          controller: _usernameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(CupertinoIcons.person),
            labelText: 'Username',
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final String username = _usernameController.text;
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
