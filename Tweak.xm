#import "Tweak.h"

id module;
NSMutableDictionary* mainPreferenceDict;
BOOL isTweakEnabled;

static void loadPrefs() {
    mainPreferenceDict = nil;
    mainPreferenceDict = [[NSMutableDictionary alloc] initWithContentsOfFile:GENERAL_PREFS];
    isTweakEnabled = [mainPreferenceDict objectForKey:@"isTweakEnabled"] ? [[mainPreferenceDict objectForKey:@"isTweakEnabled"] boolValue] : YES;
}

%group backgrounderStateGroup
%hook CCUIToggleViewController
- (void)setModule:(id)arg1 {
    %orig(arg1);
    if ([arg1 isKindOfClass:NSClassFromString(@"BackgrounderActionCC")]) {
        module = arg1;
    } 
}
%end

%hook SpringBoard
- (void)frontDisplayDidChange:(id)arg1 {
    NSLog(@"omriku here with %@",arg1);
    %orig(arg1);
    if (arg1 == nil || (module != nil && [module isSelected]) || isTweakEnabled == NO || [arg1 isKindOfClass:NSClassFromString(@"SBApplication")] == NO) {
        return;
    }

    if (module) {
        // if module is not activated, check if should be activated
        BOOL isAppShouldActivateToggle = NO;
        for (id key in mainPreferenceDict[@"selectedApps"]) {
            if ([key isEqualToString:[(SBApplication *)arg1 bundleIdentifier]]) {
                isAppShouldActivateToggle = YES;
                break;
            }
        }

        if (isAppShouldActivateToggle == YES) {
            [module setSelected:YES];
            [(CCUIToggleModule *)module refreshState];
        }
	}
}
%end
%end

%ctor {
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.0xkuj.backgrounderaction15autostateprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    %init(backgrounderStateGroup);
}