//
//  ViewController.h
//  FireBaseChat_TypeC
//
//  Created by JuneK on 09/10/2019.
//  Copyright © 2019 JuneK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseDataHelper.h"

@interface ViewController : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate, UITextFieldDelegate>
{
    NSArray *pickOption;
    NSDictionary *dic1;
    NSDictionary *dic2;
    NSDictionary *dic3;
    NSDictionary *dic4;
    NSDictionary *dic5;
    
    NSDictionary *arrDic;
    
    UIPickerView *pickerView;
    
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, weak) FirebaseDataHelper* dataHelper;
@property (strong, nonatomic) FIRDatabaseReference *ref;


@end
