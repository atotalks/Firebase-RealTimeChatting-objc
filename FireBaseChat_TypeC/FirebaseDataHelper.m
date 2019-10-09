//
//  FirebaseDataHelper.m
//  FireBase_TypeB
//
//  Created by JuneK on 22/09/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import "FirebaseDataHelper.h"


@implementation FirebaseDataHelper



+ (id)sharedManager {
    static FirebaseDataHelper *sharedFirebaseDataHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFirebaseDataHelper = [[self alloc] init];
    });
    return sharedFirebaseDataHelper;
}



- (id)init
{
    self = [super init];
    if(self)
    {
        _ref = [[FIRDatabase database] reference];
        self.isSign = false;
    }
    
    return self;
}

-(NSString *)currentUserId {
    return [FIRAuth auth].currentUser.uid;
}

-(void)signIn:(NSString*)email pwd:(NSString*)pwd {
    
    [[FIRAuth auth] signInWithEmail:email
                           password:pwd
                        completion:^(FIRAuthDataResult * _Nullable authResult,
                                     NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"Sign failed");
        }
        
        self.isSign = true;
        self.authResult = authResult;
        
    }];
    
}

- (void(^)(NSString *))instanceBlock
{
    return ^(NSString *str)
    {
        NSLog(@"Output: %@", str);
    };
}









@end
