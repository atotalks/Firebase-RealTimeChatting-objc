//
//  FirebaseDataHelper.h
//  FireBase_TypeB
//
//  Created by JuneK on 22/09/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@import Firebase;

@interface FirebaseDataHelper : NSObject
{
    
}

@property (nonatomic, retain) FIRDatabaseReference *ref;
@property (nonatomic, retain) FIRAuthDataResult *authResult;

@property (nonatomic) BOOL isSign;

+ (FirebaseDataHelper*)shared;
+ (id)sharedManager;





-(NSString *)currentUserId;
-(void)signIn:(NSString*)email pwd:(NSString*)pwd;

//- (void(^)(NSString *))instanceBlock;


//void (^signIn)(void);

@end
#define IVFirebaseDataHelper [FirebaseDataHelper shared]

NS_ASSUME_NONNULL_END
