//
//  KVCMutableArray.h
//  KVCODemo
//
//  Created by Marcos Felipe Souza on 12/11/2017.
//  Copyright © 2017 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVCMutableArray : NSObject
@property (nonatomic, strong) NSMutableArray *array;


-(NSUInteger)countOfArray;
-(id)objectInArrayAtIndex:(NSUInteger)index;
-(void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index;
-(void)removeObjectFromArrayAtIndex:(NSUInteger)index;
-(void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object;
@end
