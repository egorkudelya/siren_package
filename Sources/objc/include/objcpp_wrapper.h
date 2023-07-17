#pragma once

#import <Foundation/Foundation.h>


@interface SirenWrapper: NSObject

- (NSString*)processTrack:(NSString*)trackPath;
NS_SWIFT_NAME(processTrack(trackPath:));

@end
