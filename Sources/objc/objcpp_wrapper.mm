#import "objcpp_wrapper.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#include <client_wrapper.h>
#pragma clang diagnostic pop

using Wrapper = siren::client::ClientWrapper;

@interface SirenWrapper()

@property (readonly) Wrapper wrapper;

- (instancetype)initWithWrapper:(Wrapper)wrapper;

@end

@implementation SirenWrapper

- (instancetype)initWithWrapper:(Wrapper)wrapper {
    self = [super init];
    _wrapper = wrapper;
    return self;
}

- (NSString*)processTrack:(NSString*)trackPath {
    std::string path = std::string([trackPath UTF8String]);
    std::string res = _wrapper.process_track(path);
    NSString* NSres = [NSString stringWithUTF8String:res.c_str()];
    return NSres;
}

@end
