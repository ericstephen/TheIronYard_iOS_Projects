//
//  MSARequest.m
//  Mayorships
//
//  Created by Eric Williams on 8/19/14.
//  Copyright (c) 2014 Eric Williams. All rights reserved.
//

#import "MSARequest.h"

#define API @"https://api.foursquare.com/v2/"
#define CLIENT_ID @"1PI1LD1CEZK3LONADHVYTZFWGND3K2LUKSSRK4IWBOQMOF2F"
#define CLIENT_SECRET @"HVKFUUZL22VYVNYQPKA3PMTM5ANCH3TE2OXWIO2DCQ0WX3WL"


@implementation MSARequest

//+ (NSArray *)findMayorshipsWithLocation:(CLLocation *)location
+(void)findMayorshipsWithLocation:(CLLocation *)location completion:(void (^)(NSArray * mayors))completion
{
//    NSArray * venues = [MSARequest findVenuesWithLocation:location];
    
    [MSARequest findVenuesWithLocation:location completion:^(NSArray * venues) {
        
        NSMutableArray * mayorsArray = [@[] mutableCopy];
    
        for (NSDictionary * venue in venues)
        {
            NSString * endpoint = [NSString stringWithFormat: @"venues/%@", venue [@"id"]];
            
            //      NSDictionary * venueInfo = [MSARequest foursquareRequestWithEndpoint:endpoint andParamaters:@{}];
            
            [MSARequest foursquareRequestWithEndpoint:endpoint andParamaters:@{} completion:^(NSDictionary *responseInfo) {
                
                NSDictionary * mayor = responseInfo[@"response"][@"venue"][@"mayor"];
                
                if(mayor) [mayorsArray addObject:mayor];
                if(completion) completion(mayorsArray);
            }];
        }
    }];
    
}

+ (void)findVenuesWithLocation:(CLLocation *)location completion:(void(^)(NSArray * venues))completion
{
    NSDictionary * parameters = @{
                                  @"ll" : [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude, location.coordinate.longitude]
                                  
                                  };
    
    [MSARequest foursquareRequestWithEndpoint:@"venues/search" andParamaters:parameters completion:^(NSDictionary *responseInfo) {
        
        if (completion) completion(responseInfo[@"response"][@"venues"]);
        
    }];

//    return [MSARequest foursquareRequestWithEndpoint:@"venues/search" andParamaters:parameters][@"response"][@"venues"];
    
}

+ (void)foursquareRequestWithEndpoint:(NSString *)endpoint andParamaters:(NSDictionary *)parameters completion:(void(^)(NSDictionary * responseInfo))completion
{
    NSMutableString * requestString = [[API stringByAppendingString:endpoint] mutableCopy];
    
    // make v custom to current day
    
    NSDate * currentDate = [[NSDate alloc]init];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSString *localDateString = [dateFormatter stringFromDate:currentDate];
 
    [requestString appendString:[NSString stringWithFormat:@"?client_id=%@&client_secret=%@&v=%@", CLIENT_ID, CLIENT_SECRET,localDateString]];
    
    for (NSString * key in [parameters allKeys])
    {
        
        [requestString appendFormat:@"&%@=%@", key, [parameters objectForKey: key]];
    }
    
    NSLog(@"%@",requestString);
    NSURL * requestURL = [NSURL URLWithString:requestString];
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError)
        {
            NSLog(@"uhoh error %@", connectionError);
        }
        NSDictionary * responseInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if(completion) completion(responseInfo);
    
    }];
   
//    return responseInfo;

}


@end

