import 'package:enough_icalendar/enough_icalendar.dart';
import 'package:enough_icalendar_export/enough_icalendar_export.dart';

void main() async {
  final text = '''BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
BEGIN:VEVENT
UID:uid1@example.com
DTSTAMP:19970714T170000Z
ORGANIZER;CN=John Doe:MAILTO:john.doe@example.com
DTSTART:19970714T170000Z
DTEND:19970715T035959Z
RRULE:FREQ=YEARLY
SUMMARY:Bastille Day Party
LOCATION:Somewhere in Bastille
END:VEVENT
END:VCALENDAR''';
  final icalendar = VComponent.parse(text) as VCalendar;
  final success = await icalendar.exportToNativeCalendar();
  // alternatively use:
  //final success = await VCalendarExporter.export(icalendar);
  if (success) {
    print('event exported :-)');
  }
}
