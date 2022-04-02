import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persediaan_barang/pages/foundation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _controllerUsername = TextEditingController();
final _controllerPassword = TextEditingController();

const user = {'username': 'admin', 'password': 'admin12345'};

void login() {
  if (_controllerUsername.text == user['username'] &&
      _controllerPassword.text == user['password']) {
    Get.to(() => FoundationPage());
  } else {
    Get.snackbar(
      "GAGAL",
      "Username atau password salah!",
      icon: const Icon(CupertinoIcons.info, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autofocus: false,
              controller: _controllerUsername,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.person, color: Colors.grey),
                  hintText: 'Username',
                  border: InputBorder.none),
            ),
            TextFormField(
              obscureText: true,
              autofocus: false,
              controller: _controllerPassword,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.lock, color: Colors.grey),
                  hintText: 'Password',
                  border: InputBorder.none),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(Get.width, 40))),
                onPressed: () {
                  login();
                },
                child: const Text('MASUK'))
          ],
        ),
      ),
    );
  }
}
