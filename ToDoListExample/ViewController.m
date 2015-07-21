//
//  ViewController.m
//  ToDoListExample
//
//  Created by Manjula Jonnalagadda on 7/20/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>

@property(nonatomic,copy)NSArray *tasks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks=@[@"Learn about Buttons",@"Write code for calculator"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=self.tasks[indexPath.row];
    return cell;
}


@end
