//
//  ViewController.m
//  ToDoListExample
//
//  Created by Manjula Jonnalagadda on 7/20/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "ViewController.h"
#import "AddTaskViewController.h"
#import "Task.h"
#import "TaskTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate,AddTaskViewControllerDelegate>{
    
    NSInteger editingRow;
    NSDateFormatter *_dateFormatter;
}

@property(nonatomic,strong)NSMutableArray *tasks;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks=[NSMutableArray array];
    editingRow=-1;
    _dateFormatter=[NSDateFormatter new];
    [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    AddTaskViewController *addTaskViewController=segue.destinationViewController;
    addTaskViewController.delegate=self;
    
}

-(CGFloat)estimatedHeightForRow:(NSInteger)row{
    
    CGFloat ht=50;
    Task *task=self.tasks[row];
    if (task.taskDescription.length>0) {
        CGRect rect=[task.taskDescription boundingRectWithSize:CGSizeMake(self.view.frame.size.width-30, INFINITY) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
        ht+=rect.size.height+10;
    }
    return ht;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Task *task=self.tasks[indexPath.row];
    cell.taskNameLabel.text=task.taskName;
    cell.taskDescriptionLabel.text=task.taskDescription;
    cell.deadLineLabel.text=[_dateFormatter stringFromDate:task.deadLine];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self estimatedHeightForRow:indexPath.row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self estimatedHeightForRow:indexPath.row];
    
}


-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakself=self;
    
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [weakself.tasks removeObjectAtIndex:indexPath.row];
        [weakself.taskTableView reloadData];
        
    }];
    
    UITableViewRowAction *editAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        editingRow=indexPath.row;
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddTaskViewController *addTaskViewController=[storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
        addTaskViewController.task=self.tasks[indexPath.row];
        addTaskViewController.delegate=self;
        [self.navigationController pushViewController:addTaskViewController animated:YES];
    }];
    
    editAction.backgroundColor=[UIColor orangeColor]; 
    
    NSArray *actions=@[deleteAction,editAction];
    
    return actions;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length==0) {
        return NO;
    }
    NSLog(@"editing row %ld",editingRow);
    [textField resignFirstResponder];
    if (editingRow!=-1) {
        [self.tasks replaceObjectAtIndex:editingRow withObject:textField.text];
        editingRow=-1;
    }else{
        [self.tasks addObject:textField.text];
    }
    
    textField.text=@"";
    [self.taskTableView reloadData];
    return YES;
    
}

#pragma mark - AddTaskViewControllerDelegate

-(void)addTask:(Task *)task{
    [self.tasks addObject:task];
    [self.taskTableView reloadData];
}

-(void)refreshTasks{
    
    [self.taskTableView reloadData];
    
}

@end
