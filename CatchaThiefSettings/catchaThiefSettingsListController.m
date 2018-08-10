#include "catchaThiefSettingsListController.h"

@implementation catchaThiefSetingsListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)respring {
	system ("killall -9 SpringBoard")
}

-(void)twitter:(id)arg1 {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/jakeashacks"]];
}

-(void)github:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithStrinf:@"https://gitub.com/jakeajames/catchathief"]];
}

@end
