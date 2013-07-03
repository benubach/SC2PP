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
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile"];
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
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile"];
            
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
            [signup requestSignupForEmail:@"fake-email@nohosting.next" password:@"jajaja password" battleNetURL:@"http://notarealbnetprofile"];
            [[((NSObject*)delegate) shouldEventually] receive:@selector(signupInteractor:receivedErrorMessage:) withArguments:any(), @"Invalid Battle.net Profile"];
            
        });
    });
});
SPEC_END
