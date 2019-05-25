import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();

  UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    userProvider.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Image.asset(
              "assets/key.png",
              width: 200,
            ),
            TextFormField(
              controller: userid,
              decoration: InputDecoration(
                labelText: "User id",
              ),
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
              },
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
              },
            ),
            RaisedButton(
                child: Text("LOGIN"),
                onPressed: () async {
                  User check;
                  if (_formkey.currentState.validate()) {
                    userProvider.getUser(userid.text).then((value) {
                      if (value != null) {
                        if (value.password == password.text) {
                          check = value;
                          Navigator.pushReplacementNamed(context, "/home");
                          return;
                        }
                      }
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Userid or Password is wrong'),
                            );
                          });
                    });
                  }
                  if (check != null) {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString("userid", check.userid);
                    sharedPreferences.setString("name", check.name);
                  }
                }),
            FlatButton(
              child: Text("Register New Account"),
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
            )
          ],
        ),
      ),
    );
  }
}
