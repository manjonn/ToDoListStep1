//
//  TaskTableViewCell.m
//  ToDoListExample
//
//  Created by Manjula Jonnalagadda on 7/21/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    NSArray *vlConstraints=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_taskNameLabel][_taskDescriptionLabel][_deadLineLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_taskNameLabel,_taskDescriptionLabel,_deadLineLabel)];
    NSArray *tnlHCons=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_taskNameLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_taskNameLabel)];
    NSArray *tdlHCons=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_taskDescriptionLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_taskDescriptionLabel)];
    NSArray *dllHCons=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_deadLineLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deadLineLabel)];
    
    [self.contentView addConstraints:vlConstraints];
    [self.contentView addConstraints:tnlHCons];
    [self.contentView addConstraints:tdlHCons];
    [self.contentView addConstraints:dllHCons];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    
    [super prepareForReuse];
    self.taskNameLabel.text=@"";
    self.taskDescriptionLabel.text=@"";
    self.deadLineLabel.text=@"";
    
    
}

@end
