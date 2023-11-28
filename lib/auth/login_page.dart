import 'package:doctor_app/auth/register_page.dart';
import 'package:doctor_app/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF283793),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "images/above1.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.9,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Welcome Back ...",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF4c59a5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextFormField(
                      controller: useremailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter E-Mail';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: 'Your Email',
                          hintStyle: TextStyle(color: Colors.white60)),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFF4c59a5),
                        borderRadius: BorderRadius.circular(22)),
                    child: TextFormField(
                      controller: userpasswordcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white60)),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = useremailcontroller.text;
                          password = userpasswordcontroller.text;
                        });
                      }
                      userLogin();
                    },
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 55,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFf95f3b),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New User?",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text(
                            " Signup",
                            style: TextStyle(
                                color: Color(0xFFf95f3b),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
