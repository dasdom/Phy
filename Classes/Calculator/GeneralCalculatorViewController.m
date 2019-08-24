//  Created by Dominik Hauser on 16.06.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GeneralCalculatorViewController.h"
#import "Calculator.h"
#import "HistoryTableViewController.h"
#import "GeneralCalculatorView.h"
#import "ConstantsTableViewController.h"
#import <StoreKit/StoreKit.h>

@interface GeneralCalculatorViewController ()
@property BOOL deg;
@property BOOL help;
@property NSRange lastSelectedRange;
@property (nonatomic) NSDecimalNumber *previousResult;
@end

@implementation GeneralCalculatorViewController

@synthesize deg;

- (instancetype)init {
  self = [super init];
  if (self) {
    self.calcString = [[NSMutableString alloc] initWithString: @""];
    self.historyCalcStrings = [[NSMutableArray alloc] init];
    self.lastSelectedRange = NSMakeRange(0, 0);
    self.deg = YES;
  }
  return self;
}

- (void)loadView {
  self.view = [[GeneralCalculatorView alloc] init];
}

- (GeneralCalculatorView *)contentView {
  return (GeneralCalculatorView *)self.view;
}

- (UITextView *)calcStringView {
  return [self contentView].calculationStringTextView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.calcStringView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.calcStringView.selectedRange = self.lastSelectedRange;
  [self.calcStringView becomeFirstResponder];
  
  [[self contentView] updateDEGButtonForDEGState:self.deg];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  if ([self.calcStringView.text containsString:@"="]) {
    self.lastSelectedRange = NSMakeRange(0, 0);
  } else {
    self.lastSelectedRange = self.calcStringView.selectedRange;
  }
  
  NSString *numberOfCallsKey = @"numberOfCallsKey";
  NSInteger numberOfCalls = [[NSUserDefaults standardUserDefaults] integerForKey:numberOfCallsKey];
  if (numberOfCalls > 10) {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:numberOfCallsKey];
    [SKStoreReviewController requestReview];
  } else {
    numberOfCalls += 1;
    [[NSUserDefaults standardUserDefaults] setInteger:numberOfCalls forKey:numberOfCallsKey];
  }
}

- (void)setCalcString:(NSMutableString *)calcString {
  _calcString = calcString;
  NSAttributedString *attributedCalcString = [self attributesCalcStringFromString:calcString];
  self.calcStringView.attributedText = attributedCalcString;
}

- (void)receivedFormula: (NSNotification *)note {
  NSDictionary *userInfo = [note userInfo];
  for (NSString *key in userInfo) {
    NSLog(@"%@ = %@", key, [userInfo objectForKey: key]);
  }
  [self.calcString setString: [userInfo objectForKey: @"Formula"]];
  [self.calcString appendFormat: @"_"];
}

#pragma mark -
- (NSAttributedString *)attributesCalcStringFromString:(NSString *)calcString {
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:calcString];
  
  __block NSMutableArray *openArray = [[NSMutableArray alloc] init];
  __block NSMutableArray *parenthesesPairsArray = [[NSMutableArray alloc] init];
  __block NSString *lastSubstring = nil;
  [calcString enumerateSubstringsInRange:NSMakeRange(0, calcString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
    if ([@[DDHPlus, DDHMinus, DDHTimes, DDHDivide] containsObject:substring] &&
        false == [lastSubstring isEqualToString:@"e"]) {
      
      [attributedString setAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:substringRange];
    }
    
    if ([lastSubstring isEqualToString:@"e"] && NO == [substring isEqualToString:@"x"]) {
      NSRange lastSubstringRange = NSMakeRange(substringRange.location - 1, 1);
      [attributedString setAttributes:@{NSForegroundColorAttributeName: [UIColor brownColor]} range:lastSubstringRange];
    }
    
    if ([substring isEqualToString:@"("]) {
      [openArray addObject:[NSValue valueWithRange:substringRange]];
    } else if ([substring isEqualToString:@")"]) {
      NSValue *openValue = [openArray lastObject];
      NSRange parenthesesRange;
      if (openValue) {
        NSRange openRange = [[openArray lastObject] rangeValue];
        NSInteger length = substringRange.location-openRange.location;
        if (length < 1) {
          length = 1;
        }
        parenthesesRange = NSMakeRange(openRange.location, length);
        //            } else {
        //                parenthesesRange = substringRange;
        //            }
        [parenthesesPairsArray addObject:[NSValue valueWithRange:parenthesesRange]];
        [openArray removeLastObject];
        //                NSLog(@"self.openArray.count: %d", self.openArray.count);
      }
    }
    
    lastSubstring = substring;
  }];
  
  [attributedString addAttributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]} range:NSMakeRange(0, attributedString.length)];
  
  
  NSArray *parenthesesColorArray =
  @[[UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000],
    [UIColor colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000],
    [UIColor colorWithRed:0.000 green:0.502 blue:0.000 alpha:1.000],
    [UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000],
    [UIColor colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000],
    [UIColor colorWithRed:0.502 green:0.000 blue:0.502 alpha:1.000],
    [UIColor colorWithRed:0.502 green:0.000 blue:0.251 alpha:1.000]];
  
  
  [openArray enumerateObjectsUsingBlock:^(NSValue *rangeValue, NSUInteger idx, BOOL *stop) {
    UIColor *redColor = [UIColor redColor];
    NSRange range = [rangeValue rangeValue];
    [attributedString addAttribute:NSForegroundColorAttributeName value:redColor range:range];
  }];
  
  NSInteger numberOfColors = [parenthesesColorArray count];
  [parenthesesPairsArray enumerateObjectsUsingBlock:^(NSValue *rangeValue, NSUInteger idx, BOOL *stop) {
    UIColor *color = parenthesesColorArray[idx % numberOfColors];
    NSRange parenthesesRange = [rangeValue rangeValue];
    NSRange range = NSMakeRange(parenthesesRange.location, 1);
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    range = NSMakeRange(parenthesesRange.location+parenthesesRange.length, 1);
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
  }];
  
  return attributedString;
}
#pragma mark -

- (void)constButtonPressed:(UIButton *)sender {
  
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Liste oft benutzter Konstanten anzeigen", @"");
    return;
  }
  
  ConstantsTableViewController *constsViewController = [[ConstantsTableViewController alloc] init];
  constsViewController.delegate = self;
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:constsViewController];
  [self presentViewController:navController animated:YES completion:nil];
}

- (void)buttonPressedDown:(UIButton *)sender {
  sender.layer.borderColor = [[UIColor blueColor] CGColor];
}

#pragma mark -
#pragma mark Number Buttons

- (void)insertDigit:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if ([self help] == YES) {
    [self showHelpTextForButton:sender];
    return;
  }
  
  NSString *stringToInsert = @"";
  switch (sender.tag) {
    case DDHButtonTagZero: stringToInsert = @"0"; break;
    case DDHButtonTagOne: stringToInsert = @"1"; break;
    case DDHButtonTagTwo: stringToInsert = @"2"; break;
    case DDHButtonTagThree: stringToInsert = @"3"; break;
    case DDHButtonTagFour: stringToInsert = @"4"; break;
    case DDHButtonTagFive: stringToInsert = @"5"; break;
    case DDHButtonTagSix: stringToInsert = @"6"; break;
    case DDHButtonTagSeven: stringToInsert = @"7"; break;
    case DDHButtonTagEight: stringToInsert = @"8"; break;
    case DDHButtonTagNine: stringToInsert = @"9"; break;
    case DDHButtonTagDot:
      if ([[self activeCharacterInCalcString:self.calcString] isEqualToString:@"."]) {
        stringToInsert = @"";
      } else {
        stringToInsert = @".";
      }
      break;
    default:
      break;
  }
  
  [self insertString:stringToInsert inTextView:self.calcStringView];
}

#pragma mark - calcSigns
- (void)insertBasicCalculation:(UIButton *)sender {
  sender.layer.borderColor = [UIColor.lightGrayColor CGColor];
  if (self.help) {
    [self showHelpTextForButton:sender];
    return;
  }
  
  //    if ([[self calcString] isEqualToString: @""]) {
  //        NSString *previousResult = [Calculator stringFromResult:self.previousResult];
  //        [self insertString:previousResult inTextView:self.calcStringView];
  //    }
  
  NSString *stringToInsert = @"";
  switch (sender.tag) {
    case DDHButtonTagPlus:
      stringToInsert = DDHPlus;
      break;
    case DDHButtonTagMinus:
      stringToInsert = DDHMinus;
      break;
    case DDHButtonTagTimes:
      stringToInsert = DDHTimes;
      break;
    case DDHButtonTagDevide:
      stringToInsert = DDHDivide;
      break;
    default:
      break;
  }
  
  if ([self activeCharacterIsBasicCalcSign:self.calcString]) {
    [self replaceActiveCharacterWith:stringToInsert];
  } else {
    [self insertString:stringToInsert inTextView:self.calcStringView];
  }
}

- (void)insertFunction:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (self.help) {
    [self showHelpTextForButton:sender];
    return;
  }
  
  NSString *stringToInsert = @"";
  switch (sender.tag) {
    case DDHButtonTagOpenParantheses:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@(", DDHTimes];
      } else {
        stringToInsert = @"(";
      }
      break;
    case DDHButtonTagCloseParantheses:
      stringToInsert = @")";
      break;
    case DDHButtonTagSin:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = DDHTimes;
      }
      if (self.secondFunctions) {
        stringToInsert = [stringToInsert stringByAppendingString:@"a"];
      }
      stringToInsert = [stringToInsert stringByAppendingString:@"sin("];
      break;
    case DDHButtonTagCos:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = DDHTimes;
      }
      if (self.secondFunctions) {
        stringToInsert = [stringToInsert stringByAppendingString:@"a"];
      }
      stringToInsert = [stringToInsert stringByAppendingString:@"cos("];
      break;
    case DDHButtonTagTan:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = DDHTimes;
      }
      if (self.secondFunctions) {
        stringToInsert = [stringToInsert stringByAppendingString:@"a"];
      }
      stringToInsert = [stringToInsert stringByAppendingString:@"tan("];
      break;
    case DDHButtonTagPi:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@𝜋", DDHTimes];
      } else {
        stringToInsert = @"𝜋";
      }
      break;
    case DDHButtonTagSqrt:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@sqrt(", DDHTimes];
      } else {
        stringToInsert = @"sqrt(";
      }
      break;
    case DDHButtonTagLn:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@ln(", DDHTimes];
      } else {
        stringToInsert = @"ln(";
      }
      break;
    case DDHButtonTagExp:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@exp(", DDHTimes];
      } else {
        stringToInsert = @"exp(";
      }
      break;
    case DDHButtonTagLog10:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@log10(", DDHTimes];
      } else {
        stringToInsert = @"log10(";
      }
      break;
    case DDHButtonTagLog2:
      if ([self activeCharacterIsDigitInCalcString:self.calcString]) {
        stringToInsert = [NSString stringWithFormat:@"%@log2(", DDHTimes];
      } else {
        stringToInsert = @"log2(";
      }
      break;
    case DDHButtonTagE:
      stringToInsert = @"e";
      break;
    case DDHButtonTagPower:
      stringToInsert = @"^";
      break;
    default:
      break;
  }
  
  [self insertString:stringToInsert inTextView:self.calcStringView];
}

#pragma mark - Meta
- (void)metaButtonPressed:(UIButton *)sender {
  switch (sender.tag) {
    case DDHButtonTagSecond:
      [self secondPressed:sender];
      break;
    case DDHButtonTagHistory:
      [self historyButtonPressed:sender];
      break;
    case DDHButtonTagAns:
      [self ansButtonPressed:sender];
      break;
    case DDHButtonTagDelete:
      [self deleteButtonPressed:sender];
      break;
    case DDHButtonTagConsts:
      [self constButtonPressed:sender];
      break;
    case DDHButtonTagShare:
      [self shareButtonPressed:sender];
      break;
    case DDHButtonTagMoveLeft:
      [self backButtonPressed:sender];
      break;
    case DDHButtonTagMoveRight:
      [self forwardButtonPressed:sender];
      break;
    case DDHButtonTagFourtyTwo:
      if (YES == self.help) {
        self.calcStringView.text = NSLocalizedString(@"Antwort auf die Frage aller Fragen", @"");
        return;
      }
      [self insertString:@"42" inTextView:self.calcStringView];
      break;
    case DDHButtonTagDEG:
      [self degOrRadPressed:sender];
      break;
    case DDHButtonTagsHelp:
      [self helpButtonPressed:sender];
      break;
    default:
      break;
  }
}

#pragma mark - changeButtons

- (void)secondPressed:(UIButton *)sender {
  [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Wechsel zwischen Winkelfunktionen und deren Umkehrfunktionen", @"");
    return;
  }
  
  self.secondFunctions = !self.secondFunctions;
  [[self contentView] updateButtonTitlesForSecond:self.secondFunctions];
}

- (void)degOrRadPressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Umschalten zwischen Degrees und Radian", @"");
    return;
  }
  
  self.deg = !self.deg;
  
  [[self contentView] updateDEGButtonForDEGState:self.deg];
}

- (void)helpButtonPressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (NO == self.help) {
    self.calcString = [self.calcStringView.text mutableCopy];
    self.calcStringView.text = NSLocalizedString(@"Bitte drücke die Taste, die ich Dir erklären soll. (Zum Beenden nochmal help drücken)", @"");
  } else {
    self.calcStringView.text = self.calcString;
  }
  
  self.help = !self.help;
}

- (void)deleteButtonPressed:(UIButton *)sender {
  //    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Entfernung des Zeichens vor dem Cursor", @"");
    return;
  }
  
  if ([self.calcStringView.text containsString:@"="]) {
    return;
  }
  if (self.calcStringView.text.length < 1) {
    return;
  }
  
  NSMutableString *tempCalcString = [self.calcString mutableCopy];
  
  NSRange range = self.calcStringView.selectedRange;
  range.location = range.location - 1;
  range.length = 1;
  
  [tempCalcString replaceCharactersInRange:range withString:@""];
  
  self.calcString = [tempCalcString mutableCopy];
  
  range.length = 0;
  
  self.calcStringView.selectedRange = range;
}

- (void)backButtonPressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (self.help == YES) {
    self.calcStringView.text = NSLocalizedString(@"Ein Zeichen nach links im Eingabestring", @"");
    return;
  }
  
  NSRange selectedRange = self.calcStringView.selectedRange;
  selectedRange.location = MAX(selectedRange.location-1, 0);
  self.calcStringView.selectedRange = selectedRange;
}

- (void)forwardButtonPressed:(UIButton *)sender {
  //    [[[[sender layer] sublayers] objectAtIndex: 0] setGeometryFlipped: NO];
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Ein Zeichen nach rechts im Eingabestring", @"");
    return;
  }
  
  NSRange selectedRange = self.calcStringView.selectedRange;
  selectedRange.location = MIN(selectedRange.location+1, self.calcStringView.text.length);
  self.calcStringView.selectedRange = selectedRange;
}

- (void)historyButtonPressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Liste der lezten Berechnungen anzeigen", @"");
    return;
  }
  
  HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithHistoryArray:self.historyCalcStrings];
  historyTableViewController.delegate = self;
  historyTableViewController.isCalcHistory = YES;
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: historyTableViewController];
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [navigationController setModalPresentationStyle: UIModalPresentationPageSheet];
  }
  [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)ansButtonPressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Liste der lezten Ergebnisse anzeigen", @"");
    return;
  }
  
  HistoryTableViewController *historyTableViewController = [[HistoryTableViewController alloc] initWithHistoryArray:self.historyCalcStrings];
  historyTableViewController.delegate = self;
  
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: historyTableViewController];
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [navigationController setModalPresentationStyle: UIModalPresentationPageSheet];
  }
  [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)shareButtonPressed:(UIButton *)sender {
  
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Berechnung versenden", @"");
    return;
  }
  
  if ([self.historyCalcStrings count] < 1) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Keine bisherigen Berechnungen", nil) message:NSLocalizedString(@"Es können keine vorherigen Berechnungen geteilt werden, da noch keine Berechnung durchgeführt wurde.", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    return;
  }
  
  NSDictionary *lastCalculationDict = [[self historyCalcStrings] objectAtIndex: 0];
  NSString *lastCalculation = [NSString stringWithFormat: @"%@\n=%@", lastCalculationDict[@"calcString"], lastCalculationDict[@"solution"]];
  
  UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[lastCalculation] applicationActivities:nil];
  [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)calculatePressed:(UIButton *)sender {
  [[sender layer] setBorderColor: [[UIColor lightGrayColor] CGColor]];
  if (YES == self.help) {
    self.calcStringView.text = NSLocalizedString(@"Durchführung der Berechnung", @"");
    return;
  }
  
  [self.calcStringView resignFirstResponder];
  NSInteger indexForSubstring = 0;
  NSString *lastCharString;
  if (![self.calcString isEqualToString:@""]) {
    lastCharString = [self.calcString substringFromIndex: self.calcString.length-1];
  }
  NSSet *calcSignsSet = [NSSet setWithObjects: DDHTimes, DDHMinus, DDHPlus, DDHDivide, nil];
  if ([calcSignsSet containsObject: lastCharString]) {
    [self calcSignAtTheEnd];
    return;
  }
  if ([self.calcString rangeOfString: @"("].location != NSNotFound) {
    Calculator *calculator = [[Calculator alloc] initWithDeg:YES];
    NSRange range = [calculator getRangeOfSubstringFromString: self.calcString bySearchingFor: @"("];
    indexForSubstring = range.location + range.length;
  }
  if (indexForSubstring > [self.calcString length]) {
    [self nichtGenugKlammern];
    [self.calcString appendFormat: @"_"];
  } else if ([self.calcString rangeOfString: @"pow("].location != NSNotFound &&
             [self.calcString rangeOfString: @","].location == NSNotFound) {
    [self kommaFehlt];
    [self.calcString appendFormat: @"_"];
  } else {
    [self calculateString: self.calcString];
    NSDictionary *historyDict = @{@"calcString": [self.calcString copy], @"solution": [Calculator stringFromResult:self.previousResult]};
    [self.historyCalcStrings insertObject: historyDict atIndex: 0];
    if ([[self historyCalcStrings] count] > 50) {
      [[self historyCalcStrings] removeLastObject];
    }
    
    [self.calcString setString:@""];
  }
  
} 

- (void)calculateString:(NSString *)cString {
  
  Calculator *calculator = [[Calculator alloc] initWithDeg:deg];
  NSDecimalNumber *result = [calculator calculateString: cString];
  
  [self presentResult:result forCalcString:cString];
}

- (void)presentResult:(NSDecimalNumber *)result forCalcString:(NSString *)calcString {
    
  NSString *resultString = [Calculator stringFromResult:result];
  NSString *calcStringWithResult = [NSString stringWithFormat: @"%@\n = %@", calcString, resultString];
  self.calcStringView.attributedText = [self attributesCalcStringFromString:calcStringWithResult];
    
  self.previousResult = result;
}

#pragma mark - Helper methods
- (NSString *)stringByRemoveLastCalcSignIfNeeded:(NSString *)inputString {
  NSArray *components = [inputString componentsSeparatedByString:@"_"];
  NSMutableString *returnString = [NSMutableString new];
  NSUInteger length = [components[0] length];
  if (length > 0) {
    NSString *first = components[0];
    NSString *substring = [first substringFromIndex:length-1];
    if ([@[DDHPlus, DDHMinus, DDHTimes, DDHDivide] containsObject:substring]) {
      [returnString appendString:[first substringToIndex:length-1]];
    }
  }
  [returnString appendString:@"_"];
  if ([components[1] length] > 0) {
    [returnString appendString:components[1]];
  }
  return returnString;
}

- (NSMutableString *)stringByInsertingString:(NSString *)string inInputString:(NSString *)inputString {
  NSArray *components = [inputString componentsSeparatedByString:@"_"];
  NSMutableString *first = [components[0] mutableCopy];
  [first appendString:string];
  [first appendString:@"_"];
  if ([components count] > 1 && [components[1] length] > 0) {
    [first appendString:components[1]];
  }
  return [first mutableCopy];
}

- (void)insertString:(NSString *)string inTextView:(UITextView *)textView {
  if ([textView.text containsString:@"="]) {
    textView.text = @"";
    [textView becomeFirstResponder];
    textView.selectedRange = NSMakeRange(0, 0);
  }
  NSRange selectedRange = textView.selectedRange;
  if (NO == [textView isFirstResponder]) {
    selectedRange = self.lastSelectedRange;
  }
  NSString *calcString = [textView.text stringByReplacingCharactersInRange:selectedRange withString:string];
  self.calcString = [calcString mutableCopy];
  selectedRange.location = selectedRange.location + string.length;
  selectedRange.length = 0;
  textView.selectedRange = selectedRange;
  self.lastSelectedRange = selectedRange;
}

- (void)replaceActiveCharacterWith:(NSString *)string {
  [self deleteButtonPressed:nil];
  
  [self insertString:string inTextView:self.calcStringView];
}

- (NSString *)activeCharacterInCalcString:(NSString *)inputString {
  if ([self.calcStringView.text containsString:@"="]) {
    return nil;
  }
  NSRange selectedRange = self.calcStringView.selectedRange;
  if (selectedRange.location > 0) {
    NSRange characterRange = NSMakeRange(selectedRange.location-1, 1);
    return [inputString substringWithRange:characterRange];
  }
  return nil;
}

- (BOOL)activeCharacterIsDigitInCalcString:(NSString *)inputString {
  NSString *activeCharacter = [self activeCharacterInCalcString:inputString];
  return [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"] containsObject:activeCharacter];
}

- (BOOL)stringIsDigit:(NSString *)string {
  return [@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"] containsObject:string];
}

- (BOOL)activeCharacterIsBasicCalcSign:(NSString *)inputString {
  NSString *activeCharacter = [self activeCharacterInCalcString:inputString];
  return [@[DDHPlus, DDHMinus, DDHTimes, DDHDivide] containsObject:activeCharacter];
}

- (NSRange)rangeOfActiveNumberInCalcString:(NSString *)inputString {
  NSError *error = NULL;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+[.]?\\d+_" options:NSRegularExpressionCaseInsensitive error:&error];
  NSRange range = [regex rangeOfFirstMatchInString:inputString options:0 range:NSMakeRange(0, inputString.length)];
  if (range.location == NSNotFound) {
    regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+_" options:NSRegularExpressionCaseInsensitive error:&error];
    range = [regex rangeOfFirstMatchInString:inputString options:0 range:NSMakeRange(0, inputString.length)];
  }
  return range;
}

#pragma mark - Help
- (void)showHelpTextForButton:(UIButton *)button {
  NSString *helpText = @"";
  switch (button.tag) {
    case DDHButtonTagZero: helpText = NSLocalizedString(@"Eingabe der Ziffer 0", @""); break;
    case DDHButtonTagOne: helpText = NSLocalizedString(@"Eingabe der Ziffer 1", @""); break;
    case DDHButtonTagTwo: helpText = NSLocalizedString(@"Eingabe der Ziffer 2", @""); break;
    case DDHButtonTagThree: helpText = NSLocalizedString(@"Eingabe der Ziffer 3", @""); break;
    case DDHButtonTagFour: helpText = NSLocalizedString(@"Eingabe der Ziffer 4", @""); break;
    case DDHButtonTagFive: helpText = NSLocalizedString(@"Eingabe der Ziffer 5", @""); break;
    case DDHButtonTagSix: helpText = NSLocalizedString(@"Eingabe der Ziffer 6", @""); break;
    case DDHButtonTagSeven: helpText = NSLocalizedString(@"Eingabe der Ziffer 7", @""); break;
    case DDHButtonTagEight: helpText = NSLocalizedString(@"Eingabe der Ziffer 8", @""); break;
    case DDHButtonTagNine: helpText = NSLocalizedString(@"Eingabe der Ziffer 9", @""); break;
    case DDHButtonTagDot: helpText = NSLocalizedString(@"Eingabe eines Dezimaltrennungszeichens", @""); break;
      
    case DDHButtonTagPlus: helpText = NSLocalizedString(@"Addition", @""); break;
    case DDHButtonTagMinus: helpText = NSLocalizedString(@"Subtraktion", @""); break;
    case DDHButtonTagTimes: helpText = NSLocalizedString(@"Multiplikation", @""); break;
    case DDHButtonTagDevide: helpText = NSLocalizedString(@"Division", @""); break;
    case DDHButtonTagOpenParantheses: helpText = NSLocalizedString(@"Eingabe einer öffnenden Klammer", @"");
      break;
    case DDHButtonTagCloseParantheses: helpText = NSLocalizedString(@"Eingabe einer schliessenden Klammer", @"");
      break;
    case DDHButtonTagPower: helpText = NSLocalizedString(@"Potenz", @"");
      break;
    case DDHButtonTagE: helpText = NSLocalizedString(@"Zehnerpotenz", @""); break;
    case DDHButtonTagPi: helpText = NSLocalizedString(@"Zahl Pi", @""); break;
    case DDHButtonTagAns: helpText = NSLocalizedString(@"Eingabe des letzten Ergebnisses", @"");break;
    case DDHButtonTagFourtyTwo: helpText = NSLocalizedString(@"Die Antwort auf die Frage nach dem Universum, dem Leben und dem Rest", @"");
      break;
    case DDHButtonTagLog10: helpText = NSLocalizedString(@"Logarithmus zur Basis Zehn", @""); break;
    case DDHButtonTagLog2: helpText = NSLocalizedString(@"Logarithmus zur Basis 2", @""); break;
    case DDHButtonTagLn: helpText = NSLocalizedString(@"Natürlicher Logarithmus", @""); break;
    case DDHButtonTagExp: helpText = NSLocalizedString(@"Exponentialfunktion", @""); break;
    case DDHButtonTagSqrt: helpText = NSLocalizedString(@"Wurzelfunktion", @""); break;
      //        case 16: helpText = NSLocalizedString(@"Komma für pow(,)-Funktion; nur akriv, wenn 'pow(' im String vorhanden.", @""); break;
    case DDHButtonTagSin: helpText = NSLocalizedString(@"Sinus oder Arkussinus", @""); break;
    case DDHButtonTagCos: helpText = NSLocalizedString(@"Cosinus oder Arkuscosinus", @""); break;
    case DDHButtonTagTan: helpText = NSLocalizedString(@"Tangens oder Arkustangens", @""); break;
    default: break;
  }
  self.calcStringView.text = helpText;
}

#pragma mark -
#pragma mark alerts

- (void)nichtGenugKlammern {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Klammer" message:@"Warnung: Da sind mehr oeffnende Klammern als schliessende Klammern" preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)kommaFehlt {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Komma" message:@"Warnung: pow-Funktion ohne Komma. Die pow-Funktion braucht zwei Argumente." preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)calcSignAtTheEnd {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Rechenzeichen" message:@"Rechnung endet mit einen Rechenzeichen." preferredStyle:UIAlertControllerStyleAlert];
  
  [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)insertString:(NSString *)stringToInsert {
  
  [self.calcStringView becomeFirstResponder];
  
  [self insertString:stringToInsert inTextView:self.calcStringView];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver: self];
}

//- (NSString *)stringFromResult:(NSDecimalNumber *)decimalNumber {
//    
//    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//    numberFormatter.decimalSeparator = @".";
//    numberFormatter.maximumSignificantDigits = 10;
//    
//    double doubleValue = [decimalNumber doubleValue];
//    
//    if ((doubleValue < 100000 && doubleValue > 0.001) ||
//        (doubleValue > -100000 && doubleValue < -0.001)) {
//        
//        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
//    } else {
//        
//        numberFormatter.numberStyle = NSNumberFormatterScientificStyle;
//    }
//    
//    return [[numberFormatter stringFromNumber:decimalNumber] stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
//}


@end
