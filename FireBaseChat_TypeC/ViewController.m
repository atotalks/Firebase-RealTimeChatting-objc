//
//  ViewController.m
//  FireBaseChat_TypeC
//
//  Created by JuneK on 09/10/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import "ViewController.h"
#import "ChatVC.h"
#import <FIRApp.h>
#import <Firebase/Firebase.h>
#import <FirebaseAuth/FirebaseAuth.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeArray];
}

-(void) initializeArray {
    
    pickOption = [[NSArray alloc]initWithObjects:@"bill", @"john", @"babarian", @"lara", @"nilson", nil];
    
    
    NSDictionary *dict1 = @{ @"name" : @"bill", @"email" : @"bill@fbase.com" , @"uid" : @"F20hK8pstXa0J8SYN2olD1KiGr33" };
    dic1 = [[NSDictionary alloc] initWithDictionary:dict1];
    
    NSDictionary *dict2 = @{ @"name" : @"john", @"email" : @"john@fbase.com" , @"uid" : @"PGKpfTTVGhTjR0od60mweFKrMlo2" };
    dic2 = [[NSDictionary alloc] initWithDictionary:dict2];
    
    NSDictionary *dict3 = @{ @"name" : @"babarian", @"email" : @"babarian@fbase.com" , @"uid" : @"SvYUac5a9odkLdNOn1j1FijTyiY2" };
    dic3 = [[NSDictionary alloc] initWithDictionary:dict3];
    
    NSDictionary *dict4 = @{ @"name" : @"lara", @"email" : @"lara@fbase.com" , @"uid" : @"D4l7mSQjhvZgocqV04Mt6chkt193" };
    dic4 = [[NSDictionary alloc] initWithDictionary:dict4];
    
    NSDictionary *dict5 = @{ @"name" : @"nilson", @"email" : @"nilson@fbase.com" , @"uid" : @"1eeAAgCqnfT44j0jOgGFMjDrKt42" };
    dic5 = [[NSDictionary alloc] initWithDictionary:dict5];
    
    arrDic = [NSMutableDictionary new];
    
    [arrDic setValue:dic1 forKey:@"bill@fbase.com"];
    [arrDic setValue:dic2 forKey:@"john@fbase.com"];
    [arrDic setValue:dic3 forKey:@"babarian@fbase.com"];
    [arrDic setValue:dic4 forKey:@"lara@fbase.com"];
    [arrDic setValue:dic5 forKey:@"nilson@fbase.com"];
    
    pickerView              = [[UIPickerView alloc] init];
    pickerView.frame        = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230.0);
    pickerView.delegate     = self;
    pickerView.dataSource   = self;
    
    self.textField.delegate = self;
    [self.textField setInputView:pickerView];
    //    [self.textField setInputAccessoryView:pickerAccView];
    [self.view addSubview:self.textField];
    
    
    self.ref = [[FIRDatabase database] reference];
    
    
    
}

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

#
# pragma mark - picker view
#


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickOption count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [pickOption objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.textField.text = pickOption[row];
    
    switch (row) {
        case 0: {
            
            [[FIRAuth auth] signInWithEmail:@"bill@fbase.com"
                                   password:@"123456"
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                if (error) {
                    NSLog(@"signInWithEmail failed");
                }
                [self openChattingView:authResult];
                
            }];
            
            break;
        }
            
            
        case 1: {
            
            [[FIRAuth auth] signInWithEmail:@"john@fbase.com"
                                   password:@"123456"
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                if (error) {
                    NSLog(@"signInWithEmail failed");
                }
                [self openChattingView:authResult];
                
            }];
            
            break;
        }
            
            
        case 2: {
            [[FIRAuth auth] signInWithEmail:@"babarian@fbase.com"
                                   password:@"123456"
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                if (error) {
                    NSLog(@"signInWithEmail failed");
                }
                [self openChattingView:authResult];
                
            }];
            break;
        }
            
            
        case 3: {
            [[FIRAuth auth] signInWithEmail:@"lara@fbase.com"
                                   password:@"123456"
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                if (error) {
                    NSLog(@"signInWithEmail failed");
                }
                [self openChattingView:authResult];
                
            }];
            
            break;
        }
            
            
        case 4: {
            [[FIRAuth auth] signInWithEmail:@"nilson@fbase.com"
                                   password:@"123456"
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                if (error) {
                    NSLog(@"signInWithEmail failed");
                }
                [self openChattingView:authResult];
                
            }];
            break;
        }
            
            
    }
    
    [self.textField resignFirstResponder];
}


-(void)openChattingView:(FIRAuthDataResult *)sender {
    FIRAuthDataResult *idc = (FIRAuthDataResult *)sender;
    
    NSDictionary *rdic = [arrDic objectForKey:[[idc user] email]];
    
    FIRDatabaseReference *refChat = [[_ref child:@"chat"] child:[FIRAuth auth].currentUser.uid];
    NSDictionary *post = @{@"email": [rdic objectForKey:@"email"],
                           @"name": [rdic objectForKey:@"name"],
                           @"uid": [rdic objectForKey:@"uid"]};
    NSDictionary *childUpdates = @{[NSString stringWithFormat:@"/chat/%@/", refChat.key]: post};
    [_ref updateChildValues:childUpdates withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
        if (error) {
            
            NSLog(@"Data could not be saved: %@", error);
            
        } else {
            
            
            FIRDatabaseReference *ref2 = [[FIRDatabase database] reference];
            NSString *akey = [[ref2 child:@"group"] childByAutoId].key;
            NSDictionary *post2 = @{@"uid": [rdic objectForKey:@"uid"],
                                    @"name": [rdic objectForKey:@"name"]};
            NSDictionary *childUpdates2 = @{[NSString stringWithFormat:@"/group/%@/", akey]: post2};
            [ref2 updateChildValues:childUpdates2 withCompletionBlock:^(NSError *error, FIRDatabaseReference *endRef) {
                if (error) {
                    NSLog(@"Data could not be saved: %@", error);
                } else {
                    
                    NSLog(@"ref key: %@", refChat.key);
                    
                    [self performSegueWithIdentifier:@"SecondViewSegue" sender:sender];
                }
            }];
            
        }
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"SecondViewSegue"]) {
        ChatVC *controller = (ChatVC *)segue.destinationViewController;
        controller.authDataResult = (FIRAuthDataResult *)sender;
    }
    
}


@end
