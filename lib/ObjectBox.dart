import 'package:idklolisthisbetter/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'Event.dart';

class ObjectBox {
  late Store store;
  late Box<EventEntry> events;

  // ObjectBox() async {
  //   store = await openStore().then((value) => value);
  //   events = store.then((value) => value.box<EventEntry>());
  // }
  ObjectBox._create();
  static Future<ObjectBox> create() async {
    var objectbox = ObjectBox._create();
    objectbox.store = await openStore();
    objectbox.events = objectbox.store.box<EventEntry>();
    return objectbox;
  }


  EventEntry addEvent(EventEntry e) {
    var eventID = events.put(e);
    e.id = eventID;
    return e;
  }

  List<EventEntry> addEvents(List<EventEntry> _events) {
    var eventIDs = events.putMany(_events);
    for (int i = 0; i < _events.length ; i++) {
      _events[i].id = eventIDs[i];
    }
    return _events;
  }
}