import 'package:flutter/material.dart';
import 'package:idklolisthisbetter/AddEvent.dart';
import 'package:idklolisthisbetter/Event.dart';
import 'package:idklolisthisbetter/HomePageEvent.dart';
import 'Calendar.dart';
import 'main.dart';

class EventTitle extends StatelessWidget {
  final String text;
  final IconData icon;

  EventTitle(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return
      Align(
        alignment: Alignment.centerLeft,
        child:
        Row(
          children: [
            Icon(icon),
            Text(' $text', style: TextStyle(color: Colors.white, fontSize: 24)) ,
        ]
        ),
      );
  }
}


class Home extends StatefulWidget {

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var event_temp = [
    EventEntry.title("Someotheritle", "SomeDesc"),
    EventEntry.title("Someotheritle", "SomeDessssssc"),
    EventEntry.title("Some other title", "This is for some other shit"),
    EventEntry.title("SomeTitle", "idk lol your mom fat", ),
    EventEntry.title("its joever", "lol your mom got even fatter", ),
    EventEntry.title("its joever", "some long ass fucking description to test shit out lmao bye now. JK im back whats up fuckers its yaboi depression", )
  ];
  var events = objectBox.events.getAll();
  // SizedBox(height: 4)
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
          SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70), bottomRight: Radius.circular(70)),
                  child:
                  Container(
                      height: 310,
                      color: Theme.of(context).primaryColor,
                      child: Calendars()
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 20,end: 20, top: 10),
                  child:
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          EventTitle("Pinned events", Icons.star),
                          ...events.where((element) => element.pinned).map((e) => [ HomePageEvent(e, (){setState(() {});}),SizedBox(height: 4)] ).fold(<Widget>[], (previousValue, element) => [...previousValue, ...element]),
                          EventTitle("Upcoming events", Icons.upcoming),
                          ...events.where((element) => !element.pinned).map((e) => [ HomePageEvent(e, (){setState(() {});}),SizedBox(height: 4)] ).fold(<Widget>[], (previousValue, element) => [...previousValue, ...element]),
                          TextButton(onPressed: (){ setState(() {
                            events = objectBox.addEvents(event_temp);
                          }); }, child: Text("Add elements")),
                          TextButton(
                            onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (args) => AddEvent() ));  },
                            child: Text("Add new element")),
                          TextButton(
                            onPressed: (){ setState(() {
                              objectBox.events.removeAll();
                              events = []; });   },
                            child: Text("Delete elements")),
                                      ]),
                    ),
                )
              ],
            ),
          )
      );
  }
}
