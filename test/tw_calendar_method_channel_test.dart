import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tw_calendar/tw_calendar_method_channel.dart';

void main() {
  MethodChannelTwCalendar platform = MethodChannelTwCalendar();
  const MethodChannel channel = MethodChannel('tw_calendar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
