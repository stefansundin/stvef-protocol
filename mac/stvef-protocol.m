// https://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent: (NSAppleEventDescriptor *)replyEvent {
  // Parse URL
  // TODO: Maybe validate the input a bit better
  NSString *fullUrl = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
  NSString *arg = [fullUrl substringWithRange:NSMakeRange(6, [fullUrl length]-6)];
  NSArray *args = [arg componentsSeparatedByString:@";"];
  NSString *server = [NSString stringWithFormat: @"%@:%@", args[0], args[1]];

  // Find Holomatch app
  NSURL *app;
  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Tulip Voyager.app"]) {
    app = [NSURL fileURLWithPath:@"/Applications/Tulip Voyager.app"];
  }
  else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Lilium Voyager.app"]) {
    app = [NSURL fileURLWithPath:@"/Applications/Lilium Voyager.app"];
  }

  // Launch app
  if (app) {
    NSArray *arguments = [NSArray arrayWithObjects: @"+CONNECT", server, nil];
    NSMutableDictionary *config = [[NSMutableDictionary alloc] init];
    [config setObject:arguments forKey:NSWorkspaceLaunchConfigurationArguments];
    NSWorkspace *ws = [NSWorkspace sharedWorkspace];
    [ws launchApplicationAtURL:app options:NSWorkspaceLaunchNewInstance configuration:config error:nil];
  }
  else {
    [[NSAlert alertWithMessageText:@"Error: Could not find supported holomatch app."
              defaultButton:nil
              alternateButton:nil
              otherButton:nil
              informativeTextWithFormat:@"Supported:\nLilium Voyager.app\nTulip Voyager.app\n\nYou must move the app to /Applications/"] runModal];
  }

  // Close this program
  [NSApp terminate:nil];
}

@end

int main() {
  // Make sure the shared application is created
  [NSApplication sharedApplication];

  AppDelegate *appDelegate = [AppDelegate new];
  NSAppleEventManager *sharedAppleEventManager = [NSAppleEventManager new];
  [sharedAppleEventManager setEventHandler:appDelegate
                               andSelector:@selector(handleAppleEvent:withReplyEvent:)
                             forEventClass:kInternetEventClass
                                andEventID:kAEGetURL];

  // Guess we need a window..
  NSWindow *window = [NSWindow alloc];
  [window initWithContentRect:NSMakeRect(0, 0, 200, 200)
                    styleMask:NSWindowStyleMaskTitled
                      backing:NSBackingStoreBuffered
                        defer:NO];

  [NSApp run];
  return 0;
}
