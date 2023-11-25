import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:spider_task/Login_Page.dart';
import 'main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String email_text = "";
  String password_text = "";
  String role = "Student";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              'assets/login_svg.svg',
              width: 300,
              height: 300,
            ),
            Text(
              'Register User',
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF1F487E), width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Username",
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      controller: email,
                      onChanged: (value) {
                        email_text = value;
                      },
                      cursorColor: Color(0xFF1F487E),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF1F487E), width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: "Password"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      controller: password,
                      onChanged: (value) {
                        password_text = value;
                      },
                    ),
                    RadioListTile(
                      value: "Teacher",
                      groupValue: role,
                      onChanged: (value) {
                        setState(() {
                          role="Teacher";
                        });
                      },
                      title:Text("Teacher"),
                    ),
                    RadioListTile(
                      title:Text("Student"),
                      value: "Student",
                      groupValue: role,
                      onChanged: (value) {
                        setState(() {
                          role="Student";
                        });
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: FloatingActionButton(
                        onPressed: () async {
                          BuildContext context_ = context;
                          showDialog(
                            context: context,
                            builder: (context) {
                              context_ = context;
                              return Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 5,
                                  color: Color(0xFF191D63),
                                ),
                              );
                            },
                          );
                          final r = await http.post(
                            Uri.parse(
                                'http://192.168.26.43:3000/auth/register'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'email': email_text,
                              'password': password_text,
                              'role':role
                            }),
                          );
                          if (r.statusCode == 200) {
                            Navigator.pop(context_);
                            const snackBar = SnackBar(
                              content: Text('Registered successful!'),
                            );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                                (route) => false);
                          } else if (r.statusCode == 400) {
                            Navigator.pop(context_);
                            const snackBar = SnackBar(
                              content: Text('User already exists.'),
                            );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (r.statusCode == 401) {
                            Navigator.pop(context_);
                            const snackBar = SnackBar(
                              content: Text('Error while registering user.'),
                            );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xFF1F487E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
