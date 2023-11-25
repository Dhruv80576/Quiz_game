import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spider_task/Register_Page.dart';
import 'package:spider_task/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
String email_main="";
String password_main="";
String role="";
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String email_text = "";
  String password_text = "";

  Future<http.Response> login_user(String email, String password) {
    return http.post(
      Uri.parse('http://192.168.26.43:3000/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
  }

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
              'Login User',
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
                                'http://192.168.26.43:3000/auth/login_user'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(<String, String>{
                              'email': email_text,
                              'password': password_text
                            }),
                          );
                          if (r.statusCode == 200) {
                            email_main=email_text;
                            password_main=password_text;

                            var r=await http.get(Uri.parse('http://192.168.26.43:3000/role/'+email_text));
                            role =r.body;
                            Navigator.pop(context_);
                            const snackBar = SnackBar(
                              content: Text('Login successful!'),
                            );
// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage(),), (route) => false);
                          } else if (r.statusCode == 401) {
                            Navigator.pop(context_);
                            const snackBar = SnackBar(
                              content: Text('Invalid Credentials!'),
                            );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          "Login",
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
                    SizedBox(height: 8,),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                        },
                        child: Container(child: Text('Register' ,style: TextStyle(color: Color(0xFF191D63)),),alignment: Alignment.center,))
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
