
import 'tw_calendar_platform_interface.dart';

class TwCalendar {
  Future<String?> getPlatformVersion() {
    return TwCalendarPlatform.instance.getPlatformVersion();
  }
}
