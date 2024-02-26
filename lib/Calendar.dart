import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EvenSpacedRow extends StatelessWidget {
  final List<Widget> children;
  EvenSpacedRow(this.children);
  @override
  Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      );
  }
}

class Calendars extends StatefulWidget {
  @override
  State<Calendars> createState() => _CalendarState();
}

class _CalendarState extends State<Calendars> {
  final weeks = ["Mon", "Tue", "Wen", "Thu", "Fri", "Sat", "Sun"];
  List<(num,num)> days = [];
  var month = "Month";
  var currentTime;


  @override
  void initState() {
    currentTime = DateTime.now();
    CalculateMonthDays();
    super.initState();
  }

  void NextMonth() {
    setState(() {
      currentTime = DateTime(currentTime.year,currentTime.month+1,currentTime.day);
    });
  }
  void PreviousMonth() {
    setState(() {
      currentTime = DateTime(currentTime.year,currentTime.month-1,currentTime.day);
    });
  }

  void CalculateMonthDays() {
    var datenow = currentTime;
    List<(num,num)> temp_days = [];
    var startingDay = datenow.weekday % 7;
    var lastmonthdays = DateTime(datenow.year,datenow.month, 0).day;

    for (var i = lastmonthdays - startingDay + 1 ; i <= lastmonthdays; i++) {
      temp_days.add( (i, 15));       //DateTime(datenow.year, datenow.month - 1, i.toInt()).weekday % 7 ) );
    }

    for (var i = 1; i <= DateTime(datenow.year, datenow.month+1,0).day; i++) {
      temp_days.add( (i, DateTime(datenow.year, datenow.month, i.toInt()).weekday )  );
    }

    var tmptime = DateTime.now();
    if (datenow.year == tmptime.year && datenow.month == tmptime.month) {
      var tmpday = temp_days[startingDay - 1 + tmptime.day];
      temp_days[startingDay - 1 + tmptime.day] = (tmpday.$1, 10);
    }

    var tmp = temp_days.length;
    for (var i = temp_days.length; i < 42; i++) {
      var day = i - tmp + 1;
      temp_days.add( (day, 15) );
    }

    setState(() {
      month = "${DateFormat.y().format(datenow)} ${DateFormat.MMMM().format(datenow)}";
      days = temp_days;
    });
  }


  Text daysStyle((num,num) balls) {
    switch (balls.$2) {
      case 7:
        return Text(balls.$1.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 187, 42, 54)));
      case 10:
        return Text(balls.$1.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white));
      case 15:
        return Text(balls.$1.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(60, 0, 5, 0)));
      default:
        return Text(balls.$1.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTapDown: (args) {
        if (args.localPosition.dx < 200) PreviousMonth();
        if (args.localPosition.dx > 200) NextMonth();
        CalculateMonthDays();
      },
      child:
        Column(
          children: [
            Container(
              margin:  EdgeInsetsDirectional.only(top: 23),
              child:
                Align(alignment: Alignment.centerLeft, child:
                  IconButton(padding: EdgeInsets.only(left: 20),iconSize: 40,icon:
                    Icon(Icons.menu_open_sharp), onPressed: (){},)),
            ),
            Center(child: Text(month, style: Theme.of(context).textTheme.displaySmall)),
            Container(
              margin: EdgeInsetsDirectional.only(start: 20,end: 20),
              child:
                GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2.4,
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  children:
                  weeks.map((e) =>  Text(e, style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,)).toList()
                      + days.map((e) => daysStyle(e)).toList()
                )
            ),
          ],
        )
    );
  }
}