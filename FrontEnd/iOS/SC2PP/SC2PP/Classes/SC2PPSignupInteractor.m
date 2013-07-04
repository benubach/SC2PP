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

-(BOOL)requestSignupForEmail:(NSString *)email password:(NSString *)password battleNetURL:(NSString *)profileURL error:(NSError *__autoreleasing *)error
{
    if(![self validateEmail:email password:password battleNetURL:profileURL error:error])
        return NO;
    NSString *requestBody = [NSString stringWithFormat:@"{'email':'%@', 'password':'%@', 'profileURL':'%@'}", email, password, profileURL];
    NSURL *url = [NSURL URLWithString:@"http://sc2pp.com/registerUser"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding ]];
    AFJSONRequestOperation *jsonOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Response: %@, JSON: %@", response, JSON);
        NSString *result = [JSON valueForKey:@"result"];
        if([result isEqualToString:@"success"]){
            [self.delegate signupInteractor:self receivedSuccessResponse:[JSON valueForKey:@"message"]];
        } else if([result isEqualToString:@"failed"]){
            [self.delegate signupInteractor:self receivedErrorMessage:[JSON valueForKey:@"message"]];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Response: %@, Error: %@, JSON: %@", response, error, JSON);
    }];
    [jsonOperation start];
    return YES;
}

-(BOOL)validateEmail:(NSString*)email password:(NSString *)password battleNetURL:(NSString *)profileURL error:(NSError *__autoreleasing *)error
{
    static NSString *emailFormat = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";

    if(!email){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationEmailIsNull userInfo:nil];
        return NO;
    } else if (email.length == 0){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationEmailIsEmpty userInfo:nil];
        return NO;
    } else if([email rangeOfString:emailFormat options:NSRegularExpressionSearch|NSCaseInsensitiveSearch].location == NSNotFound){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationEmailIsInvalid userInfo:nil];
        return NO;
    } else if(!password){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationPasswordIsNull userInfo:nil];
        return NO;
    } else if(password.length == 0){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationPasswordIsEmpty userInfo:nil];
        return NO;
    } else if(password.length < 8){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationPasswordIsTooShort userInfo:nil];
        return NO;
    } else if(!profileURL){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationProfileURLIsNull userInfo:nil];
        return NO;
    } else if(profileURL.length == 0){
        if(error)
            *error = [[NSError alloc] initWithDomain:SC2PPSignupValidationDomain code:SC2PPSignupValidationProfileURLIsEmpty userInfo:nil];
        return NO;
    }
    
    return YES;
}

@end
