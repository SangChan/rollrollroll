//
//  ViewController.m
//  rollrollroll
//
//  Created by SangChan on 2015. 2. 9..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Custom.h"

@interface ViewController () {
     NSArray *_pickerData;
    int actual_length;
    int random_row;
}
@property (strong, nonatomic) IBOutlet UILabel *celerbrateLabel;
@property (strong, nonatomic) IBOutlet UIButton *goButton;

@property (strong, nonatomic) IBOutlet UIPickerView *namePicker;
- (IBAction)clickedGoButton:(id)sender;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_namePicker setDataSource:self];
    [_namePicker setDelegate:self];
    
    _celerbrateLabel.hidden = YES;
    
     _pickerData = @[];
    
    actual_length = (int)_pickerData.count;
    [[self goButton] defaultStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedGoButton:(id)sender
{
    _celerbrateLabel.hidden = YES;
    random_row = arc4random_uniform(INT16_MAX);
    //random_row = arc4random() % (actual_length*100);
    [self rollPickerViewWithRow:(random_row > actual_length)? [NSNumber numberWithInt:random_row - (random_row % actual_length)] : [NSNumber numberWithInt:random_row % actual_length]];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return INT16_MAX;// _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    int new_row = row % actual_length;
    return [_pickerData objectAtIndex:new_row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 1024;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 250;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    int new_row = row % actual_length;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, pickerView.frame.size.height)];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:180];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [_pickerData objectAtIndex:new_row];
    return label;
}

- (void) animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    NSLog(@"random_row = %d , row = %ld", random_row, [_namePicker selectedRowInComponent:0]);
    if ([_namePicker selectedRowInComponent:0] != random_row) {
        int now_row = (int)[_namePicker selectedRowInComponent:0] + 1;
        int row_differnce = random_row - now_row;
         [self performSelector:@selector(rollPickerViewWithRow:) withObject:[NSNumber numberWithInt:now_row] afterDelay:(1.2 / row_differnce)];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //NSLog(@"random_row = %d , row = %d", random_row, row);
    [UIView beginAnimations:@"1" context:nil]; // nil = dummy
    [UIPickerView setAnimationDelegate:self];
    [UIPickerView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    [UIView commitAnimations];
    if (random_row - row <= 1 ) {
        NSLog(@"당첨!");
        _celerbrateLabel.alpha = 0;
        _celerbrateLabel.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            _celerbrateLabel.alpha = 1;
        }];
    }
}

- (void)rollPickerViewWithRow:(NSNumber *)row {
    [_namePicker selectRow:[row intValue] inComponent:0 animated:YES];
    [self pickerView:_namePicker didSelectRow:[row intValue] inComponent:0];
}

-(void) playSound {
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
