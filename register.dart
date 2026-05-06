import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  bool ishidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: firstname,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            TextField(
              controller: lastname,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: '+251xxxxxxxxx'),
            ),
            TextField(
              controller: password,
              obscureText: ishidden,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    ishidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      ishidden = !ishidden;
                    });
                  },
                ),
              ),
            ),
            TextField(
              controller: confirm,
              obscureText: ishidden,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    ishidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      ishidden = !ishidden;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final nameRegExp = RegExp(r'^[a-zA-Z]+$');
                final emailRegExp = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
                final phoneRegExp = RegExp(r'^\+251\d{9}$');
                if (!phoneRegExp.hasMatch(phone.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Phone must be like +251XXXXXXXXX'),
                    ),
                  );
                  return;
                }
                if (!emailRegExp.hasMatch(email.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a valid email address'),
                    ),
                  );
                  return;
                }
                if (!nameRegExp.hasMatch(firstname.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('First name must contain only letters'),
                    ),
                  );
                  return;
                }
                if (!nameRegExp.hasMatch(lastname.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Last name must contain only letters'),
                    ),
                  );
                  return;
                }

                if (password.text != confirm.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registered Successfully')),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
