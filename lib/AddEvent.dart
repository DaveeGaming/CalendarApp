import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:idklolisthisbetter/Event.dart';
import 'package:idklolisthisbetter/HomePage.dart';
import 'package:idklolisthisbetter/main.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final EventEntry entry;
  final String title;

  AddEvent() : title = "New event", entry = EventEntry.title("", "");


  AddEvent.edit(this.entry) : title = "Editing";
  State<AddEvent> createState() => _AddEventState();
}

class DateEntry extends StatelessWidget {
  final String text;
  final DateTime time;
  DateEntry(this.text,this.time);
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          if (text != "") ...[
            Text(text, style: TextStyle(fontSize: 24)),
            SizedBox(width: 10),
          ],
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                  height: 40,
                  color: Color.fromARGB(255, 117, 78, 158),
                  child:
                  Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Icon(Icons.calendar_today),
                          Text(DateFormat('  y MMM d').format(time).toString(),style: TextStyle(color: Colors.white, fontSize: 18)),
                          Spacer(),
                          Text(DateFormat('H:mm').format(time).toString(),style: TextStyle(color: Colors.white, fontSize: 18),),
                          SizedBox(width: 20,),
                        ],
                      ))
              ),
            ),
          )
        ]);
  }
}

class InputField extends StatelessWidget {
  final double height;
  final int lines;
  final String? txt;
  final double topmargin;
  final Function(String?) callback;

  InputField(this.txt,this.height, this.lines, this.topmargin, this.callback);

  @override
  Widget build(BuildContext context) {
    return
    Container(
        margin: EdgeInsetsDirectional.only(top: 5),
        height: height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 117, 78, 158), borderRadius: BorderRadius.all(Radius.circular(40))) ,
        child:
          Container(
            margin: EdgeInsetsDirectional.only(start: 15, end: 15, top: topmargin),
            child:
              TextFormField(
                maxLines: lines,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: InputBorder.none, hintText: txt),
                onChanged: (str) => callback(str),
              ),
          )
    );
  }
}

class _AddEventState extends State<AddEvent> {
  bool AllDay = false;


  void SaveAndBack() {
    //IDKYET LMAOOOO
    objectBox.events.put(widget.entry);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
  }

  void DeleteAndBack() {
    //IDKYET LMAOOOO
    if (widget.entry.id != 0) {
      objectBox.events.remove(widget.entry.id);
    }
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body:
      Column(
        children: [
          Expanded(
            flex: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(70)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 20,end: 20,top: 50),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Column(
                        children: [
                          // New / Edit
                          Text(widget.title, style: TextStyle(fontSize: 34),),
                      
                          Align(alignment: Alignment.centerLeft, child:
                            Text(" Title:", style: TextStyle(fontSize: 24),)),
                          InputField( widget.entry.title,50, 1, 0, (str){ if (str != null) widget.entry.title = str; }  ),
                      
                          SizedBox(height: 10),
                      
                          Align(alignment: Alignment.centerLeft, child:
                            Text(" Description:", style: TextStyle(fontSize: 24),)),
                          InputField(widget.entry.description,130, 4, 10,  (str){ if (str != null) widget.entry.description = str; }),
                      
                          SizedBox(height: 10),
                      
                          Row(
                            children: [
                              Align(alignment: Alignment.centerLeft, child:
                                Text(" Date:", style: TextStyle(fontSize: 24),)),
                              Spacer(),
                              Row(
                                children: [
                                  Checkbox(
                                    visualDensity: VisualDensity.standard,
                                    fillColor: MaterialStateProperty.resolveWith(
                                          (Set states) {
                                            if (states.contains(MaterialState.selected)) {return Color.fromARGB(255, 117, 78, 158);}
                                            return null;
                                          }),
                                    value: AllDay, onChanged: (arg){
                                    setState(() {
                                      AllDay = !AllDay;
                                    });},
                                    shape: CircleBorder(), ),
                                  Text("All day", style: TextStyle(fontSize: 24),),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 86,
                            child:
                              Column(
                                children:
                                  AllDay ? [
                                    DateEntry("", widget.entry.upcoming_start)
                                  ] : [
                                    DateEntry(" From:", widget.entry.upcoming_start),
                                    SizedBox(height: 6),
                                    DateEntry(" To:    ", widget.entry.upcoming_end),
                                  ]
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ),
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: GestureDetector(
              onTap: SaveAndBack,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(70)),
                child: Container(
                    width: 280,
                    color: Theme.of(context).primaryColor,
                    child: Center(child: Text("Save", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 34),  )))
              ),
            ),
          ),
          SizedBox(height: 60,
            child:
              TextButton(
                onPressed: DeleteAndBack,
                child: widget.entry.id == 0 ? Text("Back") : Text("Delete"),
              )
          ),
        ],
      )
    );
  }
}