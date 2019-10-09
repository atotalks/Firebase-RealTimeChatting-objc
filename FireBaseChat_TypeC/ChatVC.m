//
//  ChatVC.m
//  FireBase_TypeB
//
//  Created by JuneK on 23/09/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import "ChatVC.h"

@interface ChatVC ()

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tblChat reloadData];
    
    if(self.authDataResult != nil) {
        NSArray *listItems = [self.authDataResult.user.email componentsSeparatedByString:@"@"];
        self.title = [listItems objectAtIndex:0];
    }
    
    self.ref = [[FIRDatabase database] reference];
    [self fetcheMessage];
    [self startTimer];
    
    self->nsArr = [[NSMutableArray alloc] init];
    self->arrMsg = [[NSMutableArray alloc] init];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void) startTimer {
    
    NSDate *d = [NSDate dateWithTimeIntervalSinceNow: 2.0];
    self->timer = [[NSTimer alloc] initWithFireDate: d
                                           interval: 1
                                             target: self
                                           selector:@selector(realTimeCheck)
                                           userInfo:nil repeats:YES];
    
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:self->timer forMode: NSDefaultRunLoopMode];
}

-(void) stopTimer {
    [self->timer invalidate];
    self->timer = nil;
}

-(void)realTimeCheck {
    [self fetcheMessage];
}

-(void) scrolltoBottomidx {
    if (self.tblChat.contentSize.height > self.tblChat.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tblChat.contentSize.height - self.tblChat.frame.size.height + 150);
        [self.tblChat setContentOffset:offset animated:YES];
    }
}


-(void)animationTimerHandler:(NSTimer*) timer
{
    [self fetcheMessage];
}

-(void) fetcheMessage {
    
    [[self.ref child:@"message"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if(snapshot) {
            //
            NSDictionary *postDict = snapshot.value;
            if(postDict != (NSDictionary*) [NSNull null]) {
                NSLog(@"snapshot.value = %@" , postDict);
                
                
                NSArray *dicKeys = [postDict allKeys];
                
                for(int i = 0; i < [dicKeys count]; i++) {
                    NSDictionary *dic = [[NSDictionary alloc] init];
                    dic = [postDict objectForKey:[dicKeys objectAtIndex:i]];
                    
                    if([self receivefectchcompare:[dicKeys objectAtIndex:i]]) {
                        
                    }
                    else {
                        [self->arrMsg addObject:dic];
                    }
                    
                }
                
                if(self->nsArr != nil) {
                    self->nsArr = dicKeys;
                }
                
                [self.tblChat reloadData];
                [self scrolltoBottomidx];
            }
        }
        
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"withCancelBlock %@", error.localizedDescription);
    }];
    
}


-(BOOL)receivefectchcompare:(NSString*)inStr {
    
    for(int i = 0; i < [self->nsArr count]; i++) {
        NSString *comStr = [self->nsArr objectAtIndex:i];
        if([inStr isEqualToString:comStr]) {
            return true;
        }
    }
    
    return false;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - SearchBar Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if(![textField.text length]){
        
        return NO;
    }
    
    //    [txtSearch resignFirstResponder];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return true;
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrMsg count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier =@"TableViewCell";
    static NSString *CellIdentifier2 =@"TableViewCell2";
    
    NSDictionary *cDic = [arrMsg objectAtIndex:[indexPath row]];
    
    if([[cDic objectForKey:@"fromUserId"] isEqualToString:[FIRAuth auth].currentUser.uid]) {
        TableViewCell2 *itCell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        
        itCell2.lblSender.text = [cDic objectForKey:@"text"];
        itCell2.lblSender.backgroundColor = [UIColor colorWithRed:152/255.0f green:251/255.0f blue:252/255.0f alpha:1.0f];
        
        itCell2.lblSender.font = [UIFont systemFontOfSize:20];
        itCell2.lblSender.textColor = [UIColor colorWithRed:22/255 green:22/255 blue:22/255 alpha:1];
        itCell2.lblSender.layer.masksToBounds = true;
        itCell2.lblSender.layer.cornerRadius = 7;
        
        return itCell2;
    }
    else {
        TableViewCell *itCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        itCell.lblReceiver.text = [cDic objectForKey:@"text"];
        itCell.lblReceiver.backgroundColor = [UIColor lightGrayColor];
        itCell.lblReceiver.font = [UIFont systemFontOfSize:20];
        itCell.lblReceiver.textColor = [UIColor colorWithRed:22/255 green:22/255 blue:22/255 alpha:1];
        itCell.lblReceiver.layer.masksToBounds = true;
        itCell.lblReceiver.layer.cornerRadius = 7;
        
        return itCell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

- (IBAction)btnActionMsgSend:(id)sender {
    
    if([_txtMsg.text isEqualToString:@""] || _txtMsg.text == nil){
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Alert"
                                      message:@"Please type a Message"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        
        NSDictionary *post = @{@"fromUserId": [FIRAuth auth].currentUser.uid,
                               @"text": _txtMsg.text,
                               @"timestamp": [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000],
                               @"name": self.title};
        NSDictionary *childUpdates = @{
            [NSString stringWithFormat:@"/message/%@/", [[self.ref child:@"message"] childByAutoId].key]: post};
        
        [self.ref updateChildValues:childUpdates withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref){
            if(error){
                NSLog(@"update on user error %@",[error description]);
            }else{
                
                
                self.txtMsg.text = @"";
                [self.tblChat reloadData];
                [self scrolltoBottomidx];
                
            }
        }];
        
        
    }
    
}

@end
