//
//  Task.h
//  ToDoListExample
//
//  Created by Manjula Jonnalagadda on 7/21/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property(nonatomic,copy)NSString *taskName;
@property(nonatomic,copy)NSString *taskDescription;
@property(nonatomic,strong)NSDate *deadLine;

@end
