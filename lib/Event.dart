import 'package:objectbox/objectbox.dart';

enum EventEntryType {
  normal,
  concert
}

@Entity()
class EventEntry {
  @Id()
  int id = 0;
  String title;
  String description;
  bool pinned;

  @Transient()
  EventEntryType type;

  int get entrytype {
    return type.index;
  }
  set entrytype(int val) {
    type = EventEntryType.values[val];
  }

  DateTime created;
  DateTime upcoming_start;
  DateTime upcoming_end;

  EventEntry(this.title, this.description, this.pinned, this.created,
      this.upcoming_start, this.upcoming_end) : type = EventEntryType.normal;

  EventEntry.title(this.title, this.description)
   : pinned = false,
     type = EventEntryType.normal,
     created = DateTime.now(),
     upcoming_start = DateTime.now(),
     upcoming_end = DateTime.now();

}
