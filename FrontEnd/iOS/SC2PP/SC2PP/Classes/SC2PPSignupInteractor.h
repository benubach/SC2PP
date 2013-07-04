//
//  SC2PPSignupInteractor.h
//  SC2PP
//
//  Created by Benjamín Ubach Nieto on 6/30/13.
//  Copyright (c) 2013 Benjamín Ubach Nieto. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SC2PPSignupValidationDomain @"SC2PPSignupValidationDomain"
NS_OPTIONS(NSUInteger, SC2PPSignupValidationError){
    SC2PPSignupValidationEmailIsNull,
    SC2PPSignupValidationEmailIsEmpty,
    SC2PPSignupValidationEmailIsInvalid,
    SC2PPSignupValidationPasswordIsNull,
    SC2PPSignupValidationPasswordIsEmpty,
    SC2PPSignupValidationPasswordIsTooShort,
    SC2PPSignupValidationProfileURLIsNull,
    SC2PPSignupValidationProfileURLIsEmpty
};

@class SC2PPSignupInteractor;

@protocol SC2PPSignupInteractorDelegate <NSObject>

-(void)signupInteractor:(SC2PPSignupInteractor*)interactor receivedErrorMessage:(NSString*)error;
-(void)signupInteractor:(SC2PPSignupInteractor*)interactor receivedSuccessResponse:(NSString*)message;

@optional
-(BOOL)signupInteractor:(SC2PPSignupInteractor*)interactor shouldSendSignupRequestForEmail:(NSString*)email passwordHash:(NSString*)passwordHash battleNetURL:(NSString*)profileURL;
-(void)signupInteractor:(SC2PPSignupInteractor *)interactor sentURLRequest:(NSURLRequest*)request;

@end

@interface SC2PPSignupInteractor : NSObject

@property (nonatomic, weak) id<SC2PPSignupInteractorDelegate>delegate;

-(BOOL)requestSignupForEmail:(NSString*)email password:(NSString*)password battleNetURL:(NSString*)profileURL error:(NSError *__autoreleasing *)error;

@end
