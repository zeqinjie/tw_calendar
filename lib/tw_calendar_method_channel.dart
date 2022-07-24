import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tw_calendar_platform_interface.dart';

/// An implementation of [TwCalendarPlatform] that uses method channels.
class MethodChannelTwCalendar extends TwCalendarPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tw_calendar');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
