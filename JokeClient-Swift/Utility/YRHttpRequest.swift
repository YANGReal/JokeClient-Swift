//
//  YRHttpRequest.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit
import Foundation

//class func connectionWithRequest(request: NSURLRequest!, delegate: AnyObject!) -> NSURLConnection!


class YRHttpRequest: NSObject {

    init()
    {
        super.init();
    }
    
    class func requestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void)
    {
        var URL = NSURL.URLWithString(urlString)
        var req = NSURLRequest(URL: URL)
        var queue = NSOperationQueue();
        NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
            if error
            {
                dispatch_async(dispatch_get_main_queue(),
                {
                    println(error)
                    completionHandler(data:NSNull())
                })
            }
            else
            {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

                dispatch_async(dispatch_get_main_queue(),
                {
                    completionHandler(data:jsonData)
                    
                })
            }
        })
    }
    
    class func AFRequestWithURL(urlString:String,completionHandler:(data:AnyObject)->Void) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(urlString,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                //println("JSON: " + responseObject.description!)
                
                let jsonData = NSJSONSerialization.JSONObjectWithData(responseObject as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                completionHandler(data: jsonData)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                //println("Error: " + error.localizedDescription)
                
                completionHandler(data:NSNull())
            })
    }

    
    
}
