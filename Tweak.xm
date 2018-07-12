#include "capture.h"
#import <sys/stat.h>
#import <dlfcn.h>

@interface SBMediaController
+(id)sharedInstance;
-(BOOL)isRingerMuted;
-(void)setRingerMuted:(BOOL)muted;
@end

//credits to Lucas Jackson aka neoneggplant https://github.com/neoneggplant/camshot/blob/master/main.mm
void takepicture(BOOL isfront,char* filename) {

    BOOL isMuted = [[%c(SBMediaController) sharedInstance] isRingerMuted];
    if (!isMuted)  [[%c(SBMediaController) sharedInstance] setRingerMuted:true];

    capture *cam = [[capture alloc] init];
    [cam setupCaptureSession:isfront];
    [cam setfilename:[NSString stringWithFormat:@"%s" , filename]];
    [NSThread sleepForTimeInterval:0.2];

    __block BOOL done = NO;
    [cam captureWithBlock:^(UIImage *image)
     {done = YES;}];
    while (!done)
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    [cam release];

    if (!isMuted)  [[%c(SBMediaController) sharedInstance] setRingerMuted:false];
}


%hook SBFUserAuthenticationController
- (long long)_evaluateAuthenticationAttempt:(id)arg1 outError:(id)arg2 {

    long long ret = %orig;
    if (ret != 2) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/catchathief"]) {
            mkdir("/var/mobile/catchathief", 0777);
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd.MM.YY:HH.mm.ss"];
        takepicture(true, (char*)[[NSString stringWithFormat:@"/var/mobile/catchathief/%@.png", [formatter stringFromDate:[NSDate date]]] UTF8String]);
    }
    
    return ret;

}
%end

%ctor {
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/TimeToUnlock.dylib"]) {
        dlopen("/Library/MobileSubstrate/DynamicLibraries/TimeToUnlock.dylib", RTLD_LAZY | RTLD_GLOBAL); //to solve conflicts load that first
    }
}
