//  Created by dasdom on 09.08.19.
//  
//

#import "UIFont+SizeLimit.h"

@implementation UIFont (SizeLimit)

// https://stackoverflow.com/a/40196859/498796
+ (UIFont *)preferredFontWithTextStyle:(UIFontTextStyle)style maxSize:(CGFloat)maxSize {
  // Get the descriptor
  UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
  
  // Return the descriptor if it's ok
  if (fontDescriptor.pointSize <= maxSize) {
    return [UIFont fontWithDescriptor:fontDescriptor size:fontDescriptor.pointSize];
  }
  
  // Return a descriptor for the limit size
  return [UIFont fontWithDescriptor:fontDescriptor size:maxSize];
}

@end
