# enough_icalendar_export
Allows to exports a VCalendar event to the native calendar

## Installation
Add this dependency your pubspec.yaml file:

```
dependencies:
  enough_icalendar_export: ^0.1.0
```
The latest version or `enough_icalendar_export` is [![enough_icalendar_export version](https://img.shields.io/pub/v/enough_icalendar_export.svg)](https://pub.dartlang.org/packages/enough_icalendar_export).



## Usage
After importing `package:enough_icalendar_export/enough_icalendar_export.dart'` you can use the `exportToNativeCalendar()` extension method
or the `VCalendarExporter.export(icalendar)` method, in case you don't like to use extension methods.

The method will return a `Future<bool>` value with `true` when everything worked as expected.

```dart
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
  if (success) {
    print('event exported :-)');
  }
}
```

## iOS integration
In order to make this plugin work on iOS 10+, be sure to add this to your `info.plist` file:
```
<key>NSCalendarsUsageDescription</key>
<string>INSERT_REASON_HERE</string>
```
## API Documentation
Check out the full API documentation at https://pub.dev/documentation/enough_icalendar_export/latest/

## Related Projects
* Use [enough_icalendar](https://pub.dev/packages/enough_icalendar) to parse and generate iCalendar objects
* Check out [enough_mail_icalendar](https://pub.dev/packages/enough_mail_icalendar) for handling calendar invites in emails

## License
`enough_icalendar_export` is licensed under the commercial friendly [Mozilla Public License 2.0](LICENSE)

