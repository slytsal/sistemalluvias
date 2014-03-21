//
//  LluviasSet_EstructurasCell.m
//  lluviasIMC
//
//  Created by imc developer 01 on 03/03/14.
//  Copyright (c) 2014 inmeta. All rights reserved.
//

#import "LluviasSet_EstructurasCell.h"

@implementation LluviasSet_EstructurasCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchEstructuras:(UISwitch *)sender {
}
@end
