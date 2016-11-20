//
//  ViewController.m
//  memoryARC
//
//  Created by xwwang_0102 on 16/1/31.
//  Copyright © 2016年 xwwang_0102. All rights reserved.
//
#import "Person.h"
#import "ViewController.h"
#import <objc/runtime.h>

typedef void(^SDWebImageCompletionWithFinishedBlock)(UIImage *image, NSError *error);

@interface ViewController ()
{
    NSMutableDictionary *mDicCopy;
    NSMutableDictionary *mDicP;
    
    __weak NSString *string_weak_ ;
    __strong Person *person_strong_ ;
    __weak Person *person_weak_ ;
    
     NSString *_name ;
     NSArray *_nameArray ;
}

@property(nonatomic ,copy)NSString *__name ;
@property(nonatomic ,copy)NSArray *__nameArray ;

@property(nonatomic ,retain)NSMutableDictionary * mDic;
@property(nonatomic ,weak)NSMutableDictionary * weakMDic;

@property(nonatomic ,strong)NSMutableDictionary * strongMDic;

@property(nonatomic ,copy)Person * copyedPerson;

@end

@implementation ViewController

-(void)autoreleasepool
{
    UIImage *image = [UIImage imageNamed:@"wangxingwang"];
  
   // NSLog(@"Retain count of image is %ld", CFGetRetainCount((__bridge CFTypeRef)(image)));
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         for (int j = 0; j < 10; ++j) {
         {
            for (int i = 0; i < 10; ++i) {
                @autoreleasepool {
                    
                UIImage *image = [UIImage imageNamed:@"wangxingwang"];
                UIImage *image2 = [UIImage imageNamed:@"heading"];
              //  NSLog(@"Retain count of image is %ld", CFGetRetainCount((__bridge CFTypeRef)image));
                
                NSNumber *number = [NSNumber numberWithInt:(i+j)];
                NSLog(@"number = %p", number);
                }
            }
        }
    }

    });
       
    
    
    NSString *string1 = [NSString stringWithFormat:@"leichunfeng"];
   // NSString *string = [[NSString alloc] init];
   // string = @"rfgw";

    NSLog(@"Retain count of leichunfeng is %ld", CFGetRetainCount((__bridge CFTypeRef)string1));
    
    string_weak_ = string1;
    // 场景 2
         @autoreleasepool {
                 Person *string = [[Person alloc] init];
                 person_strong_ = string;
         }
    
    NSLog(@"Retain count of leichunfeng is %ld", CFGetRetainCount((__bridge CFTypeRef)person_strong_));
    
    //  场景 3
    
    @autoreleasepool {
        NSString *string3  = [NSString stringWithFormat:@"hello world"];
        string_weak_ = string3;
    }
    //string3 already released , string_weak_= nil ,crash
   // NSLog(@"Retain count of leichunfeng in 3  is %ld", CFGetRetainCount((__bridge CFTypeRef)string_weak_));
    
    Person *person = [Person new];
    person_weak_ = person;
    NSLog(@"Retain count of person is %ld", CFGetRetainCount((__bridge CFTypeRef)person));
    
    
    Person *string = nil;
    @autoreleasepool {
        string = [[Person alloc ]init];
        person_strong_ = string;
    }
     NSLog(@"Retain count of person is %ld", CFGetRetainCount((__bridge CFTypeRef)string));
    
    NSLog(@"string: %@", string_weak_);
    NSLog(@"person: %@", person_weak_);

    
}

-(void)block
{
    
    SDWebImageCompletionWithFinishedBlock block1 =  ^(UIImage *image, NSError *error) {
        if (image) {
            NSLog(@"block sucess");
        }else{
            NSLog(@"block fail");
        }
    };
    NSLog(@"Retain count of block is %ld", CFGetRetainCount((__bridge CFTypeRef)block1));

    block1(nil,nil);
    
    SDWebImageCompletionWithFinishedBlock block2 = [block1 copy];
     NSLog(@"Retain count of block is %ld", CFGetRetainCount((__bridge CFTypeRef)block2));
    
    
}

-(void)Person
{
    Person *person = [[Person alloc ]init];
    person.age = @"dfv";
    person.fromWhere = @"dfv";
    person.name = @"dfv";
    
    NSLog(@"Retain count of person is %ld", CFGetRetainCount((__bridge CFTypeRef)person));
    
    
    //Person *second = [person copy];
    _copyedPerson = person;
    NSLog(@"Retain count of _retainPerson is %ld", CFGetRetainCount((__bridge CFTypeRef)_copyedPerson));
    
    
    Person *tempPerson = _copyedPerson;
    NSLog(@"Retain count of tempPerson is %ld", CFGetRetainCount((__bridge CFTypeRef)tempPerson));
    
    Person *third = [person mutableCopy]; //error
    NSLog(@"Retain count of person is %ld", CFGetRetainCount((__bridge CFTypeRef)third));
    
    [self xx];
    
}

- (void)xx
{
    NSLog(@"Retain count of tempPerson is %ld", CFGetRetainCount((__bridge CFTypeRef)_copyedPerson));

}

-(void)ArcDictionary
{
     // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"frist",@"mkk", nil];
     id obj = [array objectAtIndex:0];
    [array removeObjectAtIndex:0];
    [array removeObjectAtIndex:0];
    // NSLog(@"%@",obj);
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)obj));
    _mDic  = @{@"e":@"xxx"}.mutableCopy;
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)_mDic));
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    
    mDicP = _mDic;
     NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
     NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    
    
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)mDicP));
    mDicCopy = [_mDic mutableCopy];
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)mDicCopy));
   
    _weakMDic = _mDic;
     NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    
    mDicP = @{@"vncfge":@"xxx"}.mutableCopy;
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)mDicP));
    
    _strongMDic = _mDic;
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    NSLog(@"%@－－－%@",mDicP ,_mDic);
    
    _strongMDic= nil;
    
   NSLog(@"the different of RetainCount in /n self.@ and _@ %ld<-->%ld",CFGetRetainCount((__bridge CFTypeRef)_mDic) ,CFGetRetainCount((__bridge CFTypeRef)self.mDic));
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)_mDic));
    
    NSString *name = [[NSString alloc] init];
     NSLog(@"Retain count name is %ld", CFGetRetainCount((__bridge CFTypeRef)name));
    _name = @"";
    NSLog(@"Retain count name is %ld", CFGetRetainCount((__bridge CFTypeRef)_name));
    
    ___name = @"";
    NSLog(@"Retain count name is %ld", CFGetRetainCount((__bridge CFTypeRef)self.__name));
    
    NSArray *nameArray = [[NSArray alloc] init];
    _nameArray = [[NSArray alloc]init];//[[NSString alloc]init];
    ___nameArray = [[NSArray alloc]init];
    NSLog(@"Retain count nameArray is %ld", CFGetRetainCount((__bridge CFTypeRef)nameArray));
    NSLog(@"Retain count nameArray is %ld", CFGetRetainCount((__bridge CFTypeRef)_nameArray));
    NSLog(@"Retain count nameArray is %ld", CFGetRetainCount((__bridge CFTypeRef)___nameArray));

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ArcDictionary];
    [self Person];
    [self block];
    [self autoreleasepool];
    [self performSelector:@selector(eat)];
    
    Person *person = [self localPerson];
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)person));
   
}

- (Person *)localPerson
{
    Person *person = [[Person alloc ]init];
    NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)person));
    return  person;
}


void I_want_eat_you(id self,SEL sel)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if (sel == @selector(eat)) {
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), I_want_eat_you, "v@:");
        
    }
    
    return [super resolveInstanceMethod:sel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"string: %@", string_weak_);
     NSLog(@"person: %@", person_weak_);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     NSLog(@"string: %@", string_weak_);
     NSLog(@"person: %@", person_weak_);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

@end
