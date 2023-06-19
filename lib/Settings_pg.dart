import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
class Settings_pg extends StatefulWidget {
  const Settings_pg({Key? key}) : super(key: key);

  @override
  State<Settings_pg> createState() => _Settings_pgState();
}
void savevalue(String value) async {
  final pref = await SharedPreferences.getInstance();
  pref.setInt('nmbr_ques',int.parse(value));
}

class _Settings_pgState extends State<Settings_pg> {
  @override
  Widget build(BuildContext context) {
    String text="";
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Align(alignment:Alignment.topCenter,child: Text("Settings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF191D63)))),
            SizedBox(height: 30,),
            Align(alignment:Alignment.topLeft,child: Container(margin:EdgeInsets.fromLTRB(20, 10, 10, 20),child: Text("Numbers of Questions in Quiz",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: TextField(
                keyboardType:TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter number only",
                   border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Color(0xFF191D63)),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)))
                ),
                onChanged: (value) {
                  text=value;
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        if(!text.isEmpty){
          savevalue(text);
        }
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomePage();
                }), (r) {
              return false;
            });
      }, label: Text("Save")),
    );
  }
}
