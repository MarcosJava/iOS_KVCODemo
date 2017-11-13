//
//  Children.h
//  KVCODemo
//
//  Created by Marcos Felipe Souza on 11/11/2017.
//  Copyright © 2017 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCMutableArray.h"

@interface Children : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSUInteger age;

@property (nonatomic, strong) Children *child;
@property (nonatomic, strong) NSMutableArray *siblings;
@property (nonatomic, strong) KVCMutableArray *cousins;



-(NSUInteger)countOfSiblings;
-(id)objectInSiblingsAtIndex:(NSUInteger)index;
-(void)insertObject:(NSString *)object inSiblingsAtIndex:(NSUInteger)index;
-(void)removeObjectFromSiblingsAtIndex:(NSUInteger)index;

@end
