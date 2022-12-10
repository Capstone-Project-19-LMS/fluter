import 'package:flutter/material.dart';
import 'package:kelompok19lmsproject/screen/homescreen.dart';
import 'package:kelompok19lmsproject/screen/registscreen.dart';
import 'package:kelompok19lmsproject/widgets/logowidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool iChecked = false;
  bool visibilityPass = false;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: const EdgeInsets.all(20),
        // width: double.infinity,
        // height: double.infinity,
        // decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.center,
        //         colors: [Color.fromARGB(255, 255, 230, 0), Colors.white])),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            logoWidget("assets/image/logo.png"),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topRight,
              child: const Text(
                'Masuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0)),
                      labelText: 'Email',
                      hintText: 'Masukan Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordTextController,
                    obscureText: !visibilityPass,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0)),
                      labelText: 'Password',
                      hintText: 'Masukan Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityPass = !visibilityPass;
                            });
                          },
                          icon: visibilityPass
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Text(
                      //   "Simpan Kata Sandi",
                      //   style: TextStyle(color: Colors.black),
                      // ),
                      // Checkbox(
                      //   value: iChecked,
                      //   onChanged: (value) {
                      //     iChecked = !iChecked;
                      //     setState(() {});
                      //   },
                      // ),
                      // const SizedBox(
                      //   width: 45,
                      // ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Lupa kata sandi?'))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: const Text('Masuk'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushReplacementNamed(context, '/register');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegistScreen()));
                        },
                        child: Text('Daftar'),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
