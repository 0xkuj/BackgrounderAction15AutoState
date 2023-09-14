#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <rootless.h>

#define GENERAL_PREFS ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.0xkuj.backgrounderaction15autostateprefs.plist")

@interface CCUIToggleModule
- (void)refreshState;
@end

@interface FBProcess
- (NSString *)bundleIdentifier;
- (NSInteger)visibility;
@end

@interface SBApplication
-(NSString *)bundleIdentifier;
@end

@interface SpringBoard
- (BOOL)backgrounderShouldKeepActiveState:(NSString *)bundleId;
@end
