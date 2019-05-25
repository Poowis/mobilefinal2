import 'package:flutter/material.dart';
import 'package:mobilefinal2/ui/friends.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  // var a = getUser();
  // SharedPreferences.getInstance().then((value) {

  // });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          // Text(userid),
          // Text(),
          RaisedButton(
            child: Text("PROFILE SETUP"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => null,
                ),
              );
            },
          ),
          RaisedButton(
            child: Text("MY FRIENDS"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FriendsScreen(),
                ),
              );
            },
          ),
          RaisedButton(
            child: Text("SIGN OUT"),
            onPressed: () async {
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.remove("userid");
              sharedPreferences.remove("name");
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
    );
  }
}
