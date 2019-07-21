//  Created by dasdom on 13.07.18.
//

#import <XCTest/XCTest.h>

#import "GeneralCalculatorViewController.h"
#import "GeneralCalculatorView.h"
#import "HistoryTableViewController.h"

@interface GeneralCalculatorViewController ()
- (NSString *)stringByRemoveLastCalcSignIfNeeded:(NSString *)input;
- (void)insertBasicCalculation:(UIButton *)sender;
- (void)insertDigit:(UIButton *)sender;
- (NSString *)stringByInsertingString:(NSString *)string inInputString:(NSString *)inputString;
- (void)insertFunction:(UIButton *)sender;
@end

@interface GeneralCalculatorViewControllerTests : XCTestCase
@property GeneralCalculatorViewController *sut;
@property UIWindow *window;
@end

@implementation GeneralCalculatorViewControllerTests

- (void)setUp {
    [super setUp];

    self.sut = [GeneralCalculatorViewController new];
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.window.rootViewController = self.sut;
    [self.window makeKeyAndVisible];
}

- (void)tearDown {

    self.sut = nil;
    self.window = nil;
    
    [super tearDown];
}

- (void)test_removeLastCalcSign1 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"+_"];
    
    XCTAssertEqualObjects(alteredCalcString, @"_");
}

- (void)test_removeLastCalcSign2 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"123+_"];
    
    XCTAssertEqualObjects(alteredCalcString, @"123_");
}

- (void)test_removeLastCalcSign3 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"1+_2"];
    
    XCTAssertEqualObjects(alteredCalcString, @"1_2");
}

- (void)test_removeLastCalcSign4 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"_"];
    
    XCTAssertEqualObjects(alteredCalcString, @"_");
}

- (void)test_removeLastCalcSign5 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"1-_2"];
    
    XCTAssertEqualObjects(alteredCalcString, @"1_2");
}

- (void)test_removeLastCalcSign6 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"1×_2"];
    
    XCTAssertEqualObjects(alteredCalcString, @"1_2");
}

- (void)test_removeLastCalcSign7 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"1÷_2"];
    
    XCTAssertEqualObjects(alteredCalcString, @"1_2");
}

- (void)test_removeLastCalcSign8 {
    NSString *alteredCalcString = [self.sut performSelector:@selector(stringByRemoveLastCalcSignIfNeeded:) withObject:@"1÷_2+3-4×5"];
    
    XCTAssertEqualObjects(alteredCalcString, @"1_2+3-4×5");
}

#pragma mark - Insert
- (void)test_insertPlus {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagPlus];
    
    XCTAssertEqualObjects(calcString, @"1+");
}

- (void)test_insertPlus_whenLastInsertedIsPlus {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1+_" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagPlus];
    
    XCTAssertEqualObjects(calcString, @"1+_");
}

- (void)test_insertPlus_whenLastInsertedIsMinus {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1-_" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagPlus];
    
    XCTAssertEqualObjects(calcString, @"1+_");
}

- (void)test_insertMinus {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagMinus];

    XCTAssertEqualObjects(calcString, @"1-");
}

- (void)test_insertTimes {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagTimes];

    XCTAssertEqualObjects(calcString, @"1×");
}

- (void)test_insertDevide {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagDevide];

    XCTAssertEqualObjects(calcString, @"1÷");
}

- (void)test_insertPlus_inTheMiddle {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagPlus];
    
    XCTAssertEqualObjects(calcString, @"1+2");
}

- (void)test_insertPlus_inTheMiddle_updatesTextInTextView {
    [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertBasicCalculation:) fromButtonWithTag:DDHButtonTagPlus];
    
    GeneralCalculatorView *view = (GeneralCalculatorView *)self.sut.view;
    UITextView *calculationTextView = [view valueForKey:@"calculationStringTextView"];
    XCTAssertEqualObjects(calculationTextView.text, @"1+2");
}

- (void)test_insertDigit0 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagZero];
    
    XCTAssertEqualObjects(calcString, @"102");
}

- (void)test_insertDigit1 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagOne];
    
    XCTAssertEqualObjects(calcString, @"112");
}

- (void)test_insertDigit2 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagTwo];

    XCTAssertEqualObjects(calcString, @"122");
}

- (void)test_insertDigit3 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagThree];

    XCTAssertEqualObjects(calcString, @"132");
}

- (void)test_insertDigit4 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagFour];

    XCTAssertEqualObjects(calcString, @"142");
}

- (void)test_insertDigit5 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagFive];

    XCTAssertEqualObjects(calcString, @"152");
}

- (void)test_insertDigit6 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagSix];

    XCTAssertEqualObjects(calcString, @"162");
}

- (void)test_insertDigit7 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagSeven];

    XCTAssertEqualObjects(calcString, @"172");
}

- (void)test_insertDigit8 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagEight];

    XCTAssertEqualObjects(calcString, @"182");
}

- (void)test_insertDigit9 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagNine];

    XCTAssertEqualObjects(calcString, @"192");
}

- (void)test_insertDot {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagDot];

    XCTAssertEqualObjects(calcString, @"1.2");
}

- (void)test_insertDigit0_setsTextInTextView {
    [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagZero];

    GeneralCalculatorView *view = (GeneralCalculatorView *)self.sut.view;
    UITextView *calculationTextView = [view valueForKey:@"calculationStringTextView"];
    XCTAssertEqualObjects(calculationTextView.text, @"102");
}

- (void)test_insertDot_whenAlreadyDot_doesNotAddDot {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertDigit:) fromButtonWithTag:DDHButtonTagDot];

    XCTAssertEqualObjects(calcString, @"1.2");
}

- (void)test_insertFunctionSin {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagSin];

    XCTAssertEqualObjects(calcString, @"1×sin(2");
}

- (void)test_insertFunctionSin_addsTimesAndSin {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagSin];

    XCTAssertEqualObjects(calcString, @"1×sin(2");
}

- (void)test_insertFunctionCos {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagCos];

    XCTAssertEqualObjects(calcString, @"1×cos(2");
}

- (void)test_insertFunctionCos_addsTimesAndCos {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagCos];

    XCTAssertEqualObjects(calcString, @"1×cos(2");
}

- (void)test_insertFunctionTan {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagTan];

    XCTAssertEqualObjects(calcString, @"1×tan(2");
}

- (void)test_insertFunctionTan_addsTimesAndTan {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagTan];

    XCTAssertEqualObjects(calcString, @"1×tan(2");
}

- (void)test_insertOpenParantheses {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagOpenParantheses];

    XCTAssertEqualObjects(calcString, @"1×(2");
}

- (void)test_insertOpenParentheses_addsTimesAndParentheses {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagOpenParantheses];

    XCTAssertEqualObjects(calcString, @"1×(2");
}

- (void)test_insertCloseParentheses {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagCloseParantheses];

    XCTAssertEqualObjects(calcString, @"1)2");
}

- (void)test_insertPi {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagPi];

    XCTAssertEqualObjects(calcString, @"1×𝜋2");
}

- (void)test_insertPi_addsTimesAndPi {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagPi];

    XCTAssertEqualObjects(calcString, @"1×𝜋2");
}

- (void)test_insertSqrt {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagSqrt];

    XCTAssertEqualObjects(calcString, @"1×sqrt(2");
}

- (void)test_insertSqrt_addsTimesAndSqrt {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagSqrt];

    XCTAssertEqualObjects(calcString, @"1×sqrt(2");
}

- (void)test_insertLn {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLn];

    XCTAssertEqualObjects(calcString, @"1×ln(2");
}

- (void)test_insertLn_addsTimesAndLn {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLn];

    XCTAssertEqualObjects(calcString, @"1×ln(2");
}

- (void)test_insertExp {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagExp];

    XCTAssertEqualObjects(calcString, @"1×exp(2");
}

- (void)test_insertExp_addsTimesAndExp {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagExp];

    XCTAssertEqualObjects(calcString, @"1×exp(2");
}

- (void)test_insertLog10 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLog10];

    XCTAssertEqualObjects(calcString, @"1×log10(2");
}

- (void)test_insertLog10_addsTimesAndLog10 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLog10];

    XCTAssertEqualObjects(calcString, @"1×log10(2");
}

- (void)test_insertLog2 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1×_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLog2];

    XCTAssertEqualObjects(calcString, @"1×log2(2");
}

- (void)test_insertLog2_addsTimesIfNeeded {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagLog2];

    XCTAssertEqualObjects(calcString, @"1×log2(2");
}

- (void)test_insertPower1 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1+1.2_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagPower];

    XCTAssertEqualObjects(calcString, @"1+1.2^(2");
}

- (void)test_insertPower2 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1.2_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagPower];

    XCTAssertEqualObjects(calcString, @"1.2^(2");
}

- (void)test_insertPower3 {
    NSString *calcString = [self calcStringWithInitialCalcString:@"2_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagPower];
    
    XCTAssertEqualObjects(calcString, @"2^(2");
}

- (void)test_insertE {
    NSString *calcString = [self calcStringWithInitialCalcString:@"1_2" invokingSelector:@selector(insertFunction:) fromButtonWithTag:DDHButtonTagE];
    
    XCTAssertEqualObjects(calcString, @"1e2");
}

#pragma mark - History
- (void)test_sharing_whenHistoryArrayIsEmpty_presentsAlert {
    self.sut.historyCalcStrings = [[NSMutableArray alloc] init];
    
    [self.sut performSelector:@selector(shareButtonPressed:) withObject:nil];
    
    XCTAssertEqual([self.sut.presentedViewController class], [UIAlertController class]);
}

- (void)doesnt_work_test_sharing_presentsActivityViewController {
    self.sut.historyCalcStrings = [[NSMutableArray alloc] init];
    [self.sut.historyCalcStrings addObject:@{@"calcString": @"foo", @"solution": @(2)}];
    
    [self.sut performSelector:@selector(shareButtonPressed:) withObject:nil];
    
    XCTAssertEqual([self.sut.presentedViewController class], [UIActivityViewController class]);
}

- (void)test_history_whenHistoryIsEmpty_showsHistory {
    self.sut.historyCalcStrings = [[NSMutableArray alloc] init];

    [self.sut performSelector:@selector(historyButtonPressed:) withObject:nil];
    
    XCTAssertEqual([self.sut.presentedViewController class], [UINavigationController class]);
}

- (void)test_history_showsHistory {
    self.sut.historyCalcStrings = [[NSMutableArray alloc] init];
    NSDictionary *historyEntry = @{@"calcString": @"foo", @"solution": @(2)};
    [self.sut.historyCalcStrings addObject:historyEntry];

    [self.sut performSelector:@selector(historyButtonPressed:) withObject:nil];
    
    XCTAssertEqual([self.sut.presentedViewController class], [UINavigationController class]);
    UINavigationController *navController = (UINavigationController *)self.sut.presentedViewController;
    HistoryTableViewController *historyController = navController.viewControllers.firstObject;
    NSArray *historyArray = [historyController valueForKey:@"calcDictArray"];
    XCTAssertEqual(historyArray, self.sut.historyCalcStrings);
    XCTAssertEqual(historyController.delegate, self.sut);
    XCTAssertEqual(historyController.isCalcHistory, YES);
}

- (void)test_answer_showsAnswers {
    self.sut.historyCalcStrings = [[NSMutableArray alloc] init];
    NSDictionary *historyEntry = @{@"calcString": @"foo", @"solution": @(2)};
    [self.sut.historyCalcStrings addObject:historyEntry];
    
    [self.sut performSelector:@selector(ansButtonPressed:) withObject:nil];
    
    XCTAssertEqual([self.sut.presentedViewController class], [UINavigationController class]);
    UINavigationController *navController = (UINavigationController *)self.sut.presentedViewController;
    HistoryTableViewController *historyController = navController.viewControllers.firstObject;
    NSArray *historyArray = [historyController valueForKey:@"calcDictArray"];
    XCTAssertEqual(historyArray, self.sut.historyCalcStrings);
    XCTAssertEqual(historyController.delegate, self.sut);
    XCTAssertEqual(historyController.isCalcHistory, NO);
}

#pragma mark - Helper
- (NSString *)calcStringWithInitialCalcString:(NSString *)initialCalcString invokingSelector:(SEL)selector fromButtonWithTag:(NSInteger)buttonTag {
  
    [self.sut.calcStringView becomeFirstResponder];
    
    NSRange underScoreRange = NSMakeRange(NSNotFound, 0);
    
    if ([initialCalcString containsString:@"_"]) {
        
        underScoreRange = [initialCalcString rangeOfString:@"_"];
        underScoreRange.length = 0;
        
        initialCalcString = [initialCalcString stringByReplacingOccurrencesOfString:@"_" withString:@""];
        
    }
    
    UIButton *button = [UIButton new];
  button.tag = buttonTag;
  [self.sut setValue:[NSMutableString stringWithString:initialCalcString] forKey:@"calcString"];
  
    if (underScoreRange.location != NSNotFound) {
        self.sut.calcStringView.selectedRange = underScoreRange;
    }
    
  [self.sut performSelector:selector withObject:button];
  
  return [self.sut valueForKey:@"calcString"];
}

@end
