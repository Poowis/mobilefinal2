import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendsScreenState();
  }
}

class FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My friends"),
      ),
      body: ListView(children: [
        RaisedButton(
          child: Text("Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FutureBuilder(
          future: friends(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print(snapshot);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }
}
