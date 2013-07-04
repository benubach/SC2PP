//
//  SC2PPSignupInteractor.m
//  SC2PP
//
//  Created by Benjamín Ubach Nieto on 6/30/13.
//  Copyright (c) 2013 Benjamín Ubach Nieto. All rights reserved.
//

#import "SC2PPSignupInteractor.h"
#import "AFNetworking.h"

@implementation SC2PPSignupInteractor

-(void)requestSignupForEmail:(NSString *)email password:(NSString *)password battleNetURL:(NSString *)profileURL
{
    NSString *requestBody = [NSString stringWithFormat:@"{'email':'%@', 'password':'%@', 'profileURL':'%@'}", email, password, profileURL];
    NSURL *url = [NSURL URLWithString:@"http://sc2pp.com/registerUser"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFJSONRequestOperation *jsonOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSString *result = [JSON valueForKey:@"result"];
        if([result isEqualToString:@"success"]){
        
            [self.delegate signupInteractor:self receivedSuccessResponse:[JSON valueForKey:@"message"]];
    
        } else if([result isEqualToString:@"failure"]){
            
            [self.delegate signupInteractor:self receivedErrorMessage:[JSON valueForKey:@"errorMessage"]];
        
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    }];
    [jsonOperation start];
}

@end
