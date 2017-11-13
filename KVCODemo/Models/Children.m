//
//  Children.m
//  KVCODemo
//
//  Created by Marcos Felipe Souza on 11/11/2017.
//  Copyright © 2017 Marcos. All rights reserved.
//

#import "Children.h"

@implementation Children

-(instancetype) init {
    self = [super init];
    if(self){
        self.name = @"";
        self.age = 0;
        self.siblings = [[NSMutableArray alloc] init];
        self.cousins = [[KVCMutableArray alloc] init];
    }
    return self;
}

//we don’t want a notification to be posted when the name property of the Children class get changed
+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"name"]) {
        return NO;
    }
    else{
        return [super automaticallyNotifiesObserversForKey:key];
    }
}


-(NSUInteger)countOfSiblings{
    return self.siblings.count;
}
-(id)objectInSiblingsAtIndex:(NSUInteger)index {
    return [self.siblings objectAtIndex:index];
}
-(void)insertObject:(NSString *)object inSiblingsAtIndex:(NSUInteger)index {
    [self.siblings insertObject:object atIndex:index];
}
-(void)removeObjectFromSiblingsAtIndex:(NSUInteger)index{
    [self.siblings removeObjectAtIndex:index];
}

//#MARK: Getters and Setters
-(void)setName:(NSString *)name{
    [self willChangeValueForKey:@"name"];
    _name = name;
    [self didChangeValueForKey:@"name"];
}

-(NSString *) description {
    return [NSString stringWithFormat:@"Name: %@ and Age: %d", self.name, self.age];
}

@end
