//
//  TDProgressBarController.h
//  DropDownTable
//
//  Created by Abby Schlageter on 17/01/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDSemiModal.h"




@interface TDProgressBarController : TDSemiModalViewController
{
    id delgate;
}

@property (nonatomic, strong) IBOutlet id delegate;
@property (nonatomic, strong) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) IBOutlet UILabel *progressLabel;

@end
