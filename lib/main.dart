import 'package:flutter/material.dart';
import 'package:meetingsecretary/Record.dart';
import 'package:meetingsecretary/myMeetings.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audio_picker/audio_picker.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting Secretary Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Meeting Secretary Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  TextField meetingTitle;
  TextField meetingMembers;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int screen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF28c188),
        title: Text(widget.title),
      ),
      drawer: new Drawer(
          child: new Column(children: <Widget>[
        new UserAccountsDrawerHeader(
          decoration: new BoxDecoration(color: Color(0xFF28c188)),
          accountName: new Text("Firstname Lastname",
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
          accountEmail: new Text(
            "Email@Domain.com",
            style: new TextStyle(color: Colors.blueGrey[50]),
          ),
          currentAccountPicture: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text(
                "FL",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Color(0xFF28c188)),
              )),
        ),
        new ListTile(
          title: new Text('My Meetings'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return myMeetings();
              }),
            );
          },
        ),
        new Divider(),
        new ListTile(
          title: new Text('About'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        new ListTile(
          title: new Text('Log out'),
          onTap: () {
            this.setState(() {
              screen = 0;
            });
            Navigator.pop(context);
          },
        ),
      ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              child: new RawMaterialButton(
                child: Text(
                  'Record',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: new CircleBorder(),
                elevation: 0.0,
                fillColor: Colors.red,
                onPressed: () {
                  Alert(
                      context: context,
                      title: "New Meetings",
                      content: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.title),
                              labelText: 'Meeting Title',
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.person_outline),
                              labelText: 'How many member?',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Record();
                              }),
                            );
                          },
                          child: Text(
                            "Start",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              child: new RawMaterialButton(
                child: Text(
                  'Upload',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                shape: new CircleBorder(),
                elevation: 0.0,
                fillColor: Colors.blue[800],
                onPressed: () {
                  //TODO: Upload fun
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
