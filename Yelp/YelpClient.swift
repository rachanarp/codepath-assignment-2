//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    enum YelpSortMode {
        case BestMatched, Distance, HighestRated
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        //var parameters = ["term": term, "location": "San Francisco"]
        var parameters = ["term": "Restaurants", "ll": "37.774866,-122.394556"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
    func searchWithTermAndCategories(term: String, sort: String!, categories:[String]!, deals:String! , radius:String!, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        //var parameters = ["term": term, "location": "San Francisco"]
        var categoryFilterStr = ""
        if categories.count>0 {
            for category : String in categories {
                categoryFilterStr += category
            }
        }
        
        //radius_filter number meters, deals_filter:Bool, sort number
        var parameters = ["term": "Thai",
            "category_filter": categoryFilterStr,
            "radius_filter": radius,
            "sort": sort,
            "deal_filter": deals,
            "ll": "37.774866,-122.394556"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
}


