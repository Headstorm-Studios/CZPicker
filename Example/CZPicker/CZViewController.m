//
//  CZViewController.m
//  CZPicker
//
//  Created by chenzeyu on 06/27/2015.
//  Copyright (c) 2014 chenzeyu. All rights reserved.
//

#import "CZViewController.h"

@interface CZViewController ()
@property NSArray *fruits;
@property NSArray *fruitImages;
@property CZPickerView *pickerWithImage;
@end

@implementation CZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fruits = @[@"All", @"Apple", @"Banana", @"Grape", @"Watermelon", @"Lychee"];
    self.fruitImages = @[[UIImage imageNamed:@"Apple"], [UIImage imageNamed:@"Banana"], [UIImage imageNamed:@"Grape"], [UIImage imageNamed:@"Watermelon"], [UIImage imageNamed:@"Lychee"]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* comment out this method to allow
 CZPickerView:titleForRow: to work.
 */
- (NSAttributedString *)czpickerView:(CZPickerView *)pickerView
               attributedTitleForRow:(NSInteger)row{
    
    NSAttributedString *att = [[NSAttributedString alloc]
                               initWithString:self.fruits[row]
                               attributes:@{
                                            NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:18.0]
                                            }];
    return att;
}

- (NSString *)czpickerView:(CZPickerView *)pickerView
               titleForRow:(NSInteger)row{
    return self.fruits[row];
}

- (UIImage *)czpickerView:(CZPickerView *)pickerView imageForRow:(NSInteger)row {
    if([pickerView isEqual:self.pickerWithImage]) {
        return self.fruitImages[row];
    }
    return nil;
}

- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView{
    return self.fruits.count;
}

- (void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemAtRow:(NSInteger)row{
    NSLog(@"%@ is chosen!", self.fruits[row]);
}

-(void)czpickerView:(CZPickerView *)pickerView didConfirmWithItemsAtRows:(NSArray *)rows{
    NSArray *sortedRows = [rows sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    for(NSNumber *n in sortedRows){
        NSInteger row = [n integerValue];
        NSLog(@"%@ is chosen!", self.fruits[row]);
    }
}

- (void)czpickerViewDidClickCancelButton:(CZPickerView *)pickerView{
    NSLog(@"Canceled.");
}

- (IBAction)showWithImages:(id)sender {
    self.pickerWithImage = [[CZPickerView alloc] initWithHeaderTitle:@"Fruits" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    self.pickerWithImage.delegate = self;
    self.pickerWithImage.dataSource = self;
    self.pickerWithImage.needFooterView = YES;
    [self.pickerWithImage show];
}

- (IBAction)showWithFooter:(id)sender {
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Fruits" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = YES;
    [picker show];
}

- (IBAction)showWithoutFooter:(id)sender {
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Fruits" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.needFooterView = NO;
    [picker show];
}

- (IBAction)showWithMultipleSelection:(id)sender {
    CZPickerView *picker = [[CZPickerView alloc] initWithHeaderTitle:@"Fruits" cancelButtonTitle:@"Cancel" confirmButtonTitle:@"Confirm"];
    picker.delegate = self;
    picker.dataSource = self;
    picker.allowMultipleSelection = YES;
    picker.selectAll = YES;
    [picker show];
}
@end
