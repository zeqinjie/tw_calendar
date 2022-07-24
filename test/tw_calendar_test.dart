import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar.dart';
import 'package:tw_calendar/tw_calendar_platform_interface.dart';
import 'package:tw_calendar/tw_calendar_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTwCalendarPlatform 
    with MockPlatformInterfaceMixin
    implements TwCalendarPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TwCalendarPlatform initialPlatform = TwCalendarPlatform.instance;

  test('$MethodChannelTwCalendar is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTwCalendar>());
  });

  test('getPlatformVersion', () async {
    TwCalendar twCalendarPlugin = TwCalendar();
    MockTwCalendarPlatform fakePlatform = MockTwCalendarPlatform();
    TwCalendarPlatform.instance = fakePlatform;
  
    expect(await twCalendarPlugin.getPlatformVersion(), '42');
  });
}
