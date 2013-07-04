//
//  SignupSpec.m
//  SC2PP
//
//  Created by Benjamín Ubach Nieto on 6/30/13.
//  Copyright 2013 Benjamín Ubach Nieto. All rights reserved.
//

#import "OHHTTPStubs.h"
#import "SC2PPSignupInteractor.h"
#import "Kiwi.h"

SPEC_BEGIN(SignupSpec)
describe(@"Signup process", ^{
    context(@"Signup", ^{
        SC2PPSignupInteractor *signup = [[SC2PPSignupInteractor alloc] init];
        __block BOOL requestSent = NO;
        
        afterEach(^{
            [OHHTTPStubs removeLastRequestHandler];
        });
        
        it(@"Sends a signup request", ^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSLog(@"Stubbing request with URL %@", request.URL);
                requestSent = YES;
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                NSLog(@"Request: %@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
                return [OHHTTPStubsResponse responseWithFile:@"SignupResponseSuccess.json" contentType:@"application/json" responseTime:0];
            }];
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile" error:NULL];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beTrue];

        });
        it(@"Calls its delegate with a success handler", ^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSLog(@"Stubbing  URL %@", [request.URL query]);
                requestSent = YES;
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFile:@"SignupResponseSuccess.json" contentType:@"application/json" responseTime:0];
            }];
            id<SC2PPSignupInteractorDelegate> delegate = [KWMock mockForProtocol:@protocol(SC2PPSignupInteractorDelegate)];
            [signup setDelegate:delegate];
            [[((NSObject*)delegate) shouldEventually] receive:@selector(signupInteractor:receivedSuccessResponse:)];
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile" error:NULL];
            
        });

        it(@"Fails for invalid Bnet Profile URL", ^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSLog(@"Stubbing request URL %@", request.URL);
                requestSent = YES;
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFile:@"SignupResponseInvalidBnetProfileURL.json" contentType:@"application/json" responseTime:0];
            }];
            id<SC2PPSignupInteractorDelegate> delegate = [KWMock mockForProtocol:@protocol(SC2PPSignupInteractorDelegate)];
            [signup setDelegate:delegate];
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile" error:NULL];
            [[((NSObject*)delegate) shouldEventually] receive:@selector(signupInteractor:receivedErrorMessage:) withArguments:any(), @"Invalid Battle.net Profile"];
            
        });
    });

    context(@"Validation", ^{
        SC2PPSignupInteractor *signup = [[SC2PPSignupInteractor alloc] init];
        NSString *nilString;
        NSString *emptyString = @"";
        NSString *invalidEmail = @"notA@ValidEmail@a.com";
        NSString *validEmail = @"validEmail@gmail.com";
        NSString *invalidPassword = @"short";
        NSString *validPassword = @"[j;c88n0,6x_:3?1";
        NSString *nonEmptyProfileURL = @"http://us.battle.net/sc2/en/profile/324/1/bnc9nbs/";

        __block BOOL requestSent = NO;
        beforeAll(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                NSLog(@"Stubbing request URL %@", request.URL);
                requestSent = YES;
                return YES;
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                return [OHHTTPStubsResponse responseWithFile:@"SignupResponseInvalidBnetProfileURL.json" contentType:@"application/json" responseTime:0];
            }];

        });
        
        afterAll(^{
            [OHHTTPStubs removeLastRequestHandler];
        });
        
        it(@"Validates e-mail is not nil", ^{
            NSError *error;
            [signup requestSignupForEmail:nilString password:validPassword battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationEmailIsNull)];
        });
        
        it(@"Validates e-mail is not empty", ^{
            NSError *error;
            [signup requestSignupForEmail:emptyString password:validPassword battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationEmailIsEmpty)];
        });
        
        it(@"Validates e-mail has a valid format", ^{
            NSError *error;
            [signup requestSignupForEmail:invalidEmail password:validPassword battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationEmailIsInvalid)];
        });

        it(@"Validates password is not nil", ^{
            NSError *error;
            [signup requestSignupForEmail:validEmail password:nilString battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationPasswordIsNull)];
        });
        
        it(@"Validates password is not empty", ^{
            NSError *error;
            [signup requestSignupForEmail:validEmail password:emptyString battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationPasswordIsEmpty)];
        });
        
        it(@"Validates password has a minimum length", ^{
            NSError *error;
            [signup requestSignupForEmail:nilString password:invalidPassword battleNetURL:nonEmptyProfileURL error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationPasswordIsTooShort)];
        });

        it(@"Validates profileURL is not nil", ^{
            NSError *error;
            [signup requestSignupForEmail:validEmail password:validPassword battleNetURL:nilString error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationProfileURLIsNull)];
        });
        
        it(@"Validates profileURL is not empty", ^{
            NSError *error;
            [signup requestSignupForEmail:validEmail password:validPassword battleNetURL:emptyString error:&error];
            [[expectFutureValue(theValue(requestSent)) shouldEventually] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:SC2PPSignupValidationDomain];
            [[theValue(error.code) should] equal:theValue(SC2PPSignupValidationProfileURLIsEmpty)];
        });

    });
});
SPEC_END
