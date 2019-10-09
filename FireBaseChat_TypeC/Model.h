//
//  Model.h
//  FireBase_TypeB
//
//  Created by JuneK on 22/09/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject


typedef struct {
    NSString* fromUserId;
    NSString* text;
    NSString* timestamp;
    NSString* name;
} ChatMessage;

typedef struct {
    NSString* key;
    NSString* name;
    NSDictionary* messages;
    
} ChatGroup;

typedef struct {
    NSString* uid;
    NSString* email;
    NSString* group;
    NSDictionary* messages;
    
} ChatUser;


@end

NS_ASSUME_NONNULL_END
