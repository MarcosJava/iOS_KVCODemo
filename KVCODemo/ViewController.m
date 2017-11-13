//
//  ViewController.m
//  KVCODemo
//
//  Created by Marcos Felipe Souza on 11/11/2017.
//  Copyright © 2017 Marcos. All rights reserved.
//

#import "ViewController.h"
#import "Children.h"


static void *child1Context = &child1Context;
static void *child2Context = &child2Context;

@interface ViewController ()

@property (nonatomic, strong) Children *child1;
@property (nonatomic, strong) Children *child2;
@property (nonatomic, strong) Children *child3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //KVC
    [self madeChild1];
    [self madeChild2];
    [self madeChild3];
    
    //#MARK: KVO -- criando o observer
    [self.child1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: child1Context];
    [self.child1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: child1Context];
    
    //Using Array and Implementation in this Children
    [self.child1 addObserver:self forKeyPath:@"siblings" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //Using Array and Basic KVC for Array's Implementation
    [self.child1 addObserver:self forKeyPath:@"cousins.array" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //fazendo notificacao na mao
//    [self.child1 willChangeValueForKey:@"name"];
//    self.child1.name = @"Michael";
//    [self.child1 didChangeValueForKey:@"name"];
    [self.child1 setValue:[NSNumber numberWithInteger:20] forKey:@"age"];

    self.child1.name = @"Marcos";
    self.child1.age = 25;
    
    
    [self.child2 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:child2Context];
    [self.child2 setValue:[NSNumber numberWithInteger:45] forKey:@"age"];
    
    //Call Notification Manually
    //[self.child1 didChangeValueForKey:@"name"];
    
    self.child1.name = @"Michael";
    
    [self.child1 insertObject:@"Alex" inSiblingsAtIndex:0];
    [self.child1 insertObject:@"Bob" inSiblingsAtIndex:1];
    [self.child1 insertObject:@"Mary" inSiblingsAtIndex:2];
    [self.child1 removeObjectFromSiblingsAtIndex:1];
    
    [self.child1.cousins insertObject:@"Antony" inArrayAtIndex:0];
    [self.child1.cousins insertObject:@"Julia" inArrayAtIndex:1];
    [self.child1.cousins replaceObjectInArrayAtIndex:0 withObject:@"Ben"];
    

}


//KVO -- criando o observabled
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSLog(@"KeyPath: %@", keyPath);
    Children *c = (Children*) object;
    NSLog(@"Object -- C: %@", c.description);
    
    if (context == child1Context){
        
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"The name of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
        
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the FIRST child was changed.");
            NSLog(@"%@", change);
        }
        
    } else if (context == child2Context) {
        
        if ([keyPath isEqualToString:@"age"]) {
            NSLog(@"The age of the SECOND child was changed.");
            NSLog(@"%@", change);
        }
        
    } else{
        if ([keyPath isEqualToString:@"siblings"]) {
            NSLog(@"%@", change);
        }
        if ([keyPath isEqualToString:@"cousins.array"]) {
            NSLog(@"%@", change);
        }
    }
}

//KVO -- Removendo
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.child1 removeObserver:self forKeyPath:@"name"];
    [self.child1 removeObserver:self forKeyPath:@"age"];
    [self.child2 removeObserver:self forKeyPath:@"age"];
}




-(void) madeChild1 {
    self.child1 = [Children new];
    [self.child1 setValue:@"George" forKey:@"name"];
    [self.child1 setValue:[NSNumber numberWithInteger:15] forKey:@"age"];
    
    NSString *childName = [self.child1 valueForKey:@"name"];
    NSUInteger childAge = [[self.child1 valueForKey:@"age"] integerValue];
    NSLog(@"%@, %d", childName, childAge);
}

-(void) madeChild2 {
    self.child2 = [[Children alloc] init];
    [self.child2 setValue:@"Mary" forKey:@"name"];
    [self.child2 setValue:[NSNumber numberWithInteger:35] forKey:@"age"];
    
    self.child2.child = [[Children alloc] init];
    [self.child2 setValue:@"Andrew" forKeyPath:@"child.name"];
    [self.child2 setValue:[NSNumber numberWithInteger:5] forKeyPath:@"child.age"];
    NSLog(@"%@, %d", self.child2.child.name, self.child2.child.age);
}

-(void) madeChild3 {
    self.child3 = [[Children alloc] init];
    self.child3.child = [[Children alloc] init];
    self.child3.child.child = [[Children alloc] init];
    
    [self.child3 setValue:@"Tom" forKeyPath:@"child.child.name"];
    [self.child3 setValue:[NSNumber numberWithInteger:2] forKeyPath:@"child.child.age"];
    
    NSLog(@"%@, %d", self.child3.child.child.name, self.child3.child.child.age);
}

@end
