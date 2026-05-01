import 'package:add_2_calendar_plus/add_2_calendar_plus.dart' as add;
import 'package:enough_icalendar/enough_icalendar.dart';

/// Extends [VCalendar] with the [exportToNativeCalendar] method.
extension AddExtension on VCalendar {
  /// Exports this calendar to the native calendar.
  ///
  /// Returns `true` when adding succeeded.
  Future<bool> exportToNativeCalendar() => VCalendarExporter.export(this);
}

/// Exports a VCalendar to the native calendar
class VCalendarExporter {
  VCalendarExporter._();

  /// Exports this calendar to the native calendar.
  ///
  /// Returns `true` when adding succeeded.
  static Future<bool> export(VCalendar calendar) async {
    final add2ModelEvent = _toEvent(calendar);
    if (add2ModelEvent == null) {
      return Future.value(false);
    }
    final result = await add.Add2Calendar.addEvent2Cal(add2ModelEvent);

    return result?.id != null;
  }

  static add.Event? _toEvent(VCalendar calendar) {
    final ev = calendar.event;
    if (ev == null) {
      return null;
    }
    final startDate = ev.start?.toLocal() ?? DateTime.now();
    final endDate =
        ev.end?.toLocal() ??
        startDate.add(ev.duration?.toDuration() ?? const Duration(hours: 1));
    //final iosParams =  add.IOSParams(reminder: )

    final attendees = <String>[];
    for (final a in ev.attendees) {
      final email = a.email;
      if (email != null) {
        attendees.add(email);
      }
    }
    final add2ModelEvent = add.Event(
      title: ev.summary ?? '',
      description: _getDescription(ev),
      location: _getLocation(ev),
      startDate: startDate,
      endDate: endDate,
      recurrence: _toRecurrence(ev.recurrenceRule),
      androidParams: add.AndroidParams(
        emailInvites: attendees.isNotEmpty ? attendees : null,
      ),
      //iosParams: iosParams,
    );
    return add2ModelEvent;
  }

  static String _getDescription(VEvent event) {
    final description = event.description;
    if (description != null) {
      return description.replaceAll('<', ' ').replaceAll('>', ' ');
    }
    return '';
  }

  static String _getLocation(VEvent event) {
    final location = event.location;
    final microsoftTeamsMeetingUrl = event.microsoftTeamsMeetingUrl;
    if (microsoftTeamsMeetingUrl != null) {
      if (location == null) {
        return microsoftTeamsMeetingUrl;
      }
      return '$location: $microsoftTeamsMeetingUrl';
    }
    return location ?? '';
  }

  static add.Recurrence? _toRecurrence(Recurrence? recurrence) {
    if (recurrence == null) {
      return null;
    }
    add.Frequency freq;
    switch (recurrence.frequency) {
      case RecurrenceFrequency.secondly:
        return null;
      case RecurrenceFrequency.minutely:
        return null;
      case RecurrenceFrequency.hourly:
        return null;
      case RecurrenceFrequency.daily:
        freq = add.Frequency.daily;
        break;
      case RecurrenceFrequency.weekly:
        freq = add.Frequency.weekly;
        break;
      case RecurrenceFrequency.monthly:
        freq = add.Frequency.monthly;
        break;
      case RecurrenceFrequency.yearly:
        freq = add.Frequency.yearly;
        break;
    }
    return add.Recurrence(
      frequency: freq,
      interval: recurrence.interval,
      ocurrences: recurrence.count,
      rRule: recurrence.toString(),
    );
  }
}
