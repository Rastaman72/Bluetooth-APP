//
//  InfoView.m
//  BT
//
//  Created by LGBS dev on 7/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)SQLPush:(id)sender {
    NSString* code;
            code=@"1";
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:code forKey:@"ID"];
        [request setDelegate:self];
        [request startAsynchronous];
        
        // Hide keyword
        
        // Clear text field
        
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.responseStatusCode == 400) {
       // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
      //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
               
        NSRange startRange = [responseString rangeOfString:@"Array{"];
        NSRange endRange = [responseString rangeOfString:@"\"}"];
        
        NSRange searchRange = NSMakeRange(startRange.location+5 , endRange.location-startRange.location+-3 );
        NSString* forJSON=[[NSString alloc]initWithString:[responseString substringWithRange:searchRange]];
        
        NSLog(@"%@",responseString);
        NSLog(@"%@",forJSON);
        
       NSDictionary *responseDict = [forJSON JSONValue];
        
       // _result.text = responseString;
        
        
    } else {
        //_result.text = @"Unexpected error";
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
   // _result.text = error.localizedDescription;
}
@end
