#import "TwCalendarPlugin.h"
#if __has_include(<tw_calendar/tw_calendar-Swift.h>)
#import <tw_calendar/tw_calendar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tw_calendar-Swift.h"
#endif

@implementation TwCalendarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTwCalendarPlugin registerWithRegistrar:registrar];
}
@end
