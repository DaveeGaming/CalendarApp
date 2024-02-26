import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:idklolisthisbetter/AddEvent.dart';
import 'package:idklolisthisbetter/Event.dart';
import 'package:idklolisthisbetter/main.dart';
import 'package:intl/intl.dart';

class HomePageEvent extends StatefulWidget {
  final EventEntry entry;
  final Function() notifyChanged;
  HomePageEvent(this.entry, this.notifyChanged);

  @override
  State<HomePageEvent> createState() => _HomePageEventState();
}

class _HomePageEventState extends State<HomePageEvent> {
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        height: 55,
        decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255, 110, 103, 116)), borderRadius: BorderRadius.all(Radius.circular(20))),
        child:
          Row(
            children: [
              Container(
                width: 30,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20), bottomStart: Radius.circular(20))),
              ),

              Expanded(
                child: ClipRect(
                  child: Slidable(
                    startActionPane: ActionPane(extentRatio: 0.3,motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            spacing: 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.zero,
                            icon: Icons.edit,
                            onPressed: (arg){ Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent.edit(widget.entry))); },
                          ),

                          if (widget.entry.pinned)...[
                            SlidableAction(
                                spacing: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.zero,
                                icon: Icons.star,
                                onPressed: (arg){
                                  widget.entry.pinned = false;
                                  objectBox.events.put(widget.entry);
                                  setState(() {});
                                  widget.notifyChanged();
                                }
                            ),
                          ]
                          else...[
                            SlidableAction(
                                spacing: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: EdgeInsets.zero,
                                icon: Icons.star_border,
                                onPressed: (arg){
                                  widget.entry.pinned = true;
                                  objectBox.events.put(widget.entry);
                                  setState(() {});
                                  widget.notifyChanged();
                                }
                            ),
                          ]
                        ]),
                    child: SizedBox(
                      height: 55,
                      child: Row(
                        children: [
                          Expanded(flex: 2,child: Align(alignment: Alignment.center,child: Text('${DateFormat.MMMd().format(widget.entry.upcoming_start)}.',softWrap: true, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)))),
                          Expanded(flex: 7,child: Text(widget.entry.title,softWrap: false ,style: TextStyle(color: Colors.white),maxLines: 2, overflow: TextOverflow.ellipsis)),
                          SizedBox(width: 10,)
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          )
      );
  }
}
