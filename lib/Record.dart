import 'package:meetingsecretary/myMeetings.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  DateTime now = new DateTime.now();
  String dateString = "";
  _RecordState() {
    dateString = now.year.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.day.toString();
  }
  Icon pauseIcon = Icon(
    Icons.play_arrow,
    size: 50.0,
    color: Colors.white,
  );
  Color pauseColor = Colors.green;

  bool pauseBotton = false;
  bool stopButton = false;
  bool startButton = false;

  final _isHours = true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );
  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
  }

  @override
  void dispose() async {
    dispose();
    await _stopWatchTimer.dispose();
  }

  void start() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stop() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void reset() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFebbf54),
        title: Text('Record'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'Meeting title',
                  //TODO: Meeting title (dialog)
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      final displayTime =
                          StopWatchTimer.getDisplayTime(value, hours: _isHours);
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 40,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('XX Persons'
                            //TODO:# of persons (dialog)
                            ''),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.date_range,
                          color: Colors.grey[700],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(dateString),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          height: 100.0,
                          child: new RawMaterialButton(
                            child: Icon(
                              Icons.stop,
                              size: 50.0,
                              color: Colors.white,
                            ),
                            shape: new CircleBorder(),
                            elevation: 0.0,
                            fillColor: Colors.red,
                            onPressed: () {
                              setState(() {
                                if (startButton = true) {
                                  stopButton = true;
                                  //pauseBotton = false;
                                  stop();
                                  reset();
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Stop Recording !!",
                                    desc:
                                        "Are you sure you want to stop meeting recording?",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "YES",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return myMeetings();
                                          }),
                                        ),
                                        color: Color.fromRGBO(0, 179, 134, 1.0),
                                      ),
                                      DialogButton(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                              gradient:
                                              LinearGradient(colors: [
                                                Color.fromRGBO(
                                                    116, 116, 191, 1.0),
                                                Color.fromRGBO(
                                                    52, 138, 199, 1.0)
                                              ]);
                                              stopButton = false;
                                            });
                                          })
                                    ],
                                  ).show();
                                } else {
                                  Alert(
                                          context: context,
                                          title: "No Record !",
                                          desc:
                                              "There is no record to save, Please start a meeting")
                                      .show();
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          child: new RawMaterialButton(
                            child: pauseIcon,
                            shape: new CircleBorder(),
                            elevation: 0.0,
                            fillColor: pauseColor,
                            onPressed: () {
                              setState(() {
                                startButton = true;
                                if (pauseBotton == true) {
                                  pauseBotton = false;
                                  pauseColor = Colors.green;
                                  pauseIcon = Icon(
                                    Icons.play_arrow,
                                    size: 50.0,
                                    color: Colors.white,
                                  );
                                  stop();
                                } else {
                                  pauseBotton = true;
                                  pauseColor = Colors.blue[500];
                                  pauseIcon = Icon(
                                    Icons.pause,
                                    size: 50.0,
                                    color: Colors.white,
                                  );
                                  start();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Color(0xFFebbf54),
                child: Text(
                  'My Meetings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (stopButton == false) {
                      Alert(
                              context: context,
                              title: "Meeting is recording !!",
                              desc: "Stop the recording first")
                          .show();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return myMeetings();
                        }),
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
