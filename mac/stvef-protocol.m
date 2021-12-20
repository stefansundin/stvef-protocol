// https://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent: (NSAppleEventDescriptor *)replyEvent {
  // Get input data
  NSString *input = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
  NSString *arg;
  if ([input hasPrefix:@"stvef://"]) {
    arg = [input substringFromIndex:8];
  }
  else if ([input hasPrefix:@"stvef:"]) {
    arg = [input substringFromIndex:6];
  }
  else {
    // invalid input
    [NSApp terminate:nil];
    return;
  }

  // Parse arg
  // TODO: Maybe validate the input a bit better
  NSArray *args = [arg componentsSeparatedByString:@";"];
  NSString *server = [NSString stringWithFormat: @"%@:%@", args[0], args[1]];
  NSArray *arguments = [NSArray arrayWithObjects: @"+CONNECT", server, nil];

  // Find Holomatch app
  NSURL *app;
  if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Tulip Voyager.app"]) {
    app = [NSURL fileURLWithPath:@"/Applications/Tulip Voyager.app"];
  }
  else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Lilium Voyager.app"]) {
    app = [NSURL fileURLWithPath:@"/Applications/Lilium Voyager.app"];
  }
  else {
    [[NSAlert alertWithMessageText:@"Error: Could not find supported holomatch app."
              defaultButton:nil
              alternateButton:nil
              otherButton:nil
              informativeTextWithFormat:@"Supported:\nLilium Voyager.app\nTulip Voyager.app\n\nYou must move the app to /Applications/"] runModal];
    [NSApp terminate:nil];
    return;
  }

  // Launch app
  NSMutableDictionary *config = [[NSMutableDictionary alloc] init];
  [config setObject:arguments forKey:NSWorkspaceLaunchConfigurationArguments];
  NSWorkspace *ws = [NSWorkspace sharedWorkspace];
  [ws launchApplicationAtURL:app options:NSWorkspaceLaunchNewInstance configuration:config error:nil];

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

  [NSApp run];
  return 0;
}
