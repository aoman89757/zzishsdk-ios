//
//  WebService.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZWebService.h"
#import "ZZPropertyService.h"


#define BASE_URL @"http://api.zzish.co.uk/api/"

@interface ZZWebService()

@property (strong,nonatomic) NSMutableData* responseData;

@end

@implementation ZZWebService

@synthesize delegate;

- (void)upload:(NSString *)endpoint withJSON:(NSString*)json {
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,endpoint]]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString* token = [ZZPropertyService appToken];
    [request addValue:token forHTTPHeaderField:@"X-ApplicationId"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = json;
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = requestBodyData;
    
    // Create url connection and fire request
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *e;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&e];
    [self.delegate process:object];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
