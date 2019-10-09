//
//  ChatVC.h
//  FireBase_TypeB
//
//  Created by JuneK on 23/09/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FIRApp.h>
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "TableViewCell.h"
#import "TableViewCell2.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatVC : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arrMsg;
    NSMutableArray *arrMsgin;
    NSArray *nsArr;
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UITextField *txtMsg;
@property (weak, nonatomic) IBOutlet UITableView *tblChat;

@property (nonatomic) FIRAuthDataResult *authDataResult;
@property (strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)btnActionMsgSend:(id)sender;

@end

NS_ASSUME_NONNULL_END
