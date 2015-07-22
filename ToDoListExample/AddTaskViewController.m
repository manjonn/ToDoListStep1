//
//  AddTaskViewController.m
//  ToDoListExample
//
//  Created by Manjula Jonnalagadda on 7/21/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface AddTaskViewController (){
    NSDateFormatter *_dateFormatter;
}

@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIToolbar *dateToolBar;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    if (self.task) {
        self.taskNameTextField.text=_task.taskName;
        self.taskDescriptionTextView.text=_task.taskDescription;
        self.datePicker.date=_datePicker.date;
        [self.dateButton setTitle:[_dateFormatter stringFromDate:_task.deadLine] forState:UIControlStateNormal];

    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTask:(Task *)task{
    _task=task;
    self.taskNameTextField.text=_task.taskName;
    self.taskDescriptionTextView.text=_task.taskDescription;
    self.datePicker.date=_datePicker.date;
    [self.dateButton setTitle:[_dateFormatter stringFromDate:_task.deadLine] forState:UIControlStateNormal];
}

- (IBAction)selectDate:(UIButton *)sender {
    if ([self.taskNameTextField isFirstResponder]) {
        if (self.taskNameTextField.text.length==0) {
            return;
        }
        [self.taskNameTextField resignFirstResponder];
    }
    
    if ([self.taskDescriptionTextView isFirstResponder]) {
        [self.taskDescriptionTextView resignFirstResponder];
    }
    
    self.datePicker.hidden=NO;
    self.dateToolBar.hidden=NO;
    
    
}
- (IBAction)save:(UIButton *)sender {
    
    if (!self.task) {
        Task *task=[[Task alloc]init];
        task.taskName=self.taskNameTextField.text;
        task.taskDescription=self.taskDescriptionTextView.text;
        task.deadLine=self.datePicker.date;
        
        if ([self.delegate respondsToSelector:@selector(addTask:)]) {
            [self.delegate addTask:task];
        }
    }else{
        self.task.taskName=self.taskNameTextField.text;
        self.task.taskDescription=self.taskDescriptionTextView.text;
        self.task.deadLine=self.datePicker.date;
        if ([self.delegate respondsToSelector:@selector(refreshTasks)]) {
            [self.delegate refreshTasks];
        }
      
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)cancelDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;

    
}
- (IBAction)doneWithDate:(UIBarButtonItem *)sender {
    
    self.datePicker.hidden=YES;
    self.dateToolBar.hidden=YES;
    [self.dateButton setTitle:[_dateFormatter stringFromDate:self.datePicker.date] forState:UIControlStateNormal];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
