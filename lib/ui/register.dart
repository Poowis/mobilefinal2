import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/user.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  UserProvider userProvider = UserProvider();
  List<User> users;
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    userProvider.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFormField(
              controller: userid,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "User id",
              ),
              validator: (value) {
                if (value.length < 6 || value.length > 12)
                  return "User Id must contain 6 to 12 chareaters";
              },
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  labelText: "Name", icon: Icon(Icons.account_circle)),
              validator: (value) {
                List<String> name = value.split(" ");
                if (name.length != 2 || name[0] == "" || name[1] == "")
                  return "Name is not valid";
              },
            ),
            TextFormField(
              controller: age,
              decoration: InputDecoration(
                  labelText: "Age", icon: Icon(Icons.calendar_today)),
              validator: (value) {
                if (isNumeric(value)) {
                  double age = double.parse(value);
                  if (age < 10 || age > 80) {
                    return "Age is not in range";
                  }
                } else {
                  return "Age is not valid";
                }
              },
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                  labelText: "Password", icon: Icon(Icons.lock)),
              obscureText: true,
              validator: (value) {
                if (!(value.length > 6)) {
                  return "Password must be longer than 6 charecters";
                }
              },
            ),
            RaisedButton(
              child: Text("Register"),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  User user = User(
                      userid: userid.text,
                      name: name.text,
                      age: age.text,
                      password: password.text);
                  userProvider.getUser(user.userid).then((value) {
                    if (value != null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Userid is already exist'),
                            );
                          });
                    } else {
                      userProvider.insert(user);
                      Navigator.pushReplacementNamed(context, "/login");
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
