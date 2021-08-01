import 'package:enough_icalendar/enough_icalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('convert duration', () {
    final isoDuration =
        IsoDuration(weeks: 2, days: 3, hours: 6, minutes: 15, seconds: 5);
    final duration = isoDuration.toDuration();
    expect(duration.inDays, 17);
    expect(duration.inHours, 17 * 24 + 6);
    expect(duration.inMinutes, (17 * 24 + 6) * 60 + 15);
  });
}
