// https://www.cocoawithlove.com/2010/09/minimalist-cocoa-programming.html
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@end

@implementation AppDelegate

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent: (NSAppleEventDescriptor *)replyEvent {
  // List of supported apps. To support a new app just it here and build from source.
  const NSArray *APPS = [NSArray arrayWithObjects:
    @"Tulip Voyager.app",
    @"Lilium Voyager.app",
    @"cMod-stvoyHM.app",
  nil];

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

  // Remove extra data
  if ([arg containsString:@"?"]) {
    NSRange questionMark = [arg rangeOfString:@"?"];
    arg = [arg substringToIndex:questionMark.location];
  }

  // Parse arg
  // TODO: Maybe validate the input a bit better
  NSString *server;
  if ([arg hasPrefix:@"connect/"]) {
    server = [arg substringFromIndex:8];
  }
  else {
    // Legacy format
    NSArray *args = [arg componentsSeparatedByString:@";"];
    server = [NSString stringWithFormat: @"%@:%@", args[0], args[1]];
  }
  NSArray *arguments = [NSArray arrayWithObjects: @"+CONNECT", server, nil];

  // Find Holomatch app
  NSURL *app = nil;
  for (id appname in APPS) {
    NSString *path = [NSString stringWithFormat: @"/Applications/%@", appname];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
      app = [NSURL fileURLWithPath:path];
    }
  }

  if (app == nil) {
    [[NSAlert alertWithMessageText:@"Error: Could not find a supported holomatch app."
              defaultButton:nil
              alternateButton:nil
              otherButton:nil
              informativeTextWithFormat:@"Supported apps:\n\n%@\n\nYou must move the app to /Applications/", [APPS componentsJoinedByString:@"\n"]] runModal];
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

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  // Close this program if it wasn't launched using a link (i.e. launched normally)
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

  [NSApp setDelegate:appDelegate];
  [NSApp run];
  return 0;
}
