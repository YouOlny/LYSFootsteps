//
//  LYSTextfield.m
//  LYSTextfield
//
//  Created by 刘永生 on 2017/3/6.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import "LYSTextfield.h"

@interface LYSTextfield ()

@property (nonatomic,copy) NSString *mSpacer;

@property (nonatomic,assign) NSInteger mMaxLimit;

@property (nonatomic,strong) NSMutableArray<NSNumber *> *mSpacerNums;


@end


@implementation LYSTextfield


- (void)dealloc {
    
    [self removeTarget:self action:@selector(changedTextfield:) forControlEvents:UIControlEventEditingChanged];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData {
    
    self.mSpacer = @" ";
    
}

- (LYSTextfield *(^)(BOOL isSpacer)) isSpacer {
    return ^id(BOOL isSpacer){
        
        [self removeTarget:self action:@selector(changedTextfield:) forControlEvents:UIControlEventEditingChanged];
        
        if (isSpacer) {
            [self addTarget:self action:@selector(changedTextfield:) forControlEvents:UIControlEventEditingChanged];
        }
        
        return self;
    };
}


- (void)changedTextfield:(UITextField *)textField {
    
    //极值的判断
    
    NSString * string = [textField.text stringByReplacingOccurrencesOfString:self.mSpacer withString:@""];
    
    if (self.mMaxLimit && string.length > self.mMaxLimit) {
        [textField setText:[textField.text substringToIndex:self.mMaxLimit]];
        return;
    }
    
    if (self.mSpacerNums.count > 0) {
        NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
        NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
        
        
        NSString *phoneNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:phoneNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPostion];
        
        textField.text = phoneNumberWithSpaces;
        UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
        [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
    }
    
}

/**
 *  除去非数字字符，确定光标正确位置
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理过后的string
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(characterToAdd != [self.mSpacer characterAtIndex:0]) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/**
 *  将空格插入我们现在的string 中，并确定我们光标的正确位置，防止在空格中
 *
 *  @param string         当前的string
 *  @param cursorPosition 光标位置
 *
 *  @return 处理后有空格的string
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    
    for (NSUInteger i=0; i<string.length; i++) {
        if(i>0)
        {
            
            for (NSNumber * spacerNum in self.mSpacerNums) {
                
                if ([spacerNum intValue] == i) {
                    [stringWithAddedSpaces appendString:self.mSpacer];
                    
                    if(i<cursorPositionInSpacelessString) {
                        (*cursorPosition)++;
                    }
                }
                
            }
        }
        
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

- (LYSTextfield *(^)(NSString *spacer)) spacer{
    return ^id(NSString *spacer){
        self.mSpacer = spacer;
        return self;
    };
}

- (LYSTextfield *(^)(NSInteger maxLimit)) maxLimit{
    return ^id(NSInteger maxLimit){
        self.mMaxLimit = maxLimit;
        return self;
    };
}

- (LYSTextfield *(^)(NSNumber * spacerNum)) spacerNum {
    
    return ^id(NSNumber * spacerNum){
        
        NSNumber * lastNum = self.mSpacerNums.lastObject;
        
        NSInteger count = [spacerNum intValue] + [lastNum intValue];
        
        [self.mSpacerNums addObject:@(count)];
        
        return self;
    };
    
}

- (LYSTextfield *(^)()) removeSpacerNums {
    
    return ^id(){
        
        [self.mSpacerNums removeAllObjects];
        
        return self;
    };
    
}

#pragma mark - 光标

/**
 获取光标
 */
- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}


- (NSMutableArray *)mSpacerNums {
    
    if(!_mSpacerNums){
        _mSpacerNums = [[NSMutableArray alloc]init];
    }
    return _mSpacerNums;
    
}


@end
