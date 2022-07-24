import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tw_calendar_method_channel.dart';

abstract class TwCalendarPlatform extends PlatformInterface {
  /// Constructs a TwCalendarPlatform.
  TwCalendarPlatform() : super(token: _token);

  static final Object _token = Object();

  static TwCalendarPlatform _instance = MethodChannelTwCalendar();

  /// The default instance of [TwCalendarPlatform] to use.
  ///
  /// Defaults to [MethodChannelTwCalendar].
  static TwCalendarPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TwCalendarPlatform] when
  /// they register themselves.
  static set instance(TwCalendarPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
