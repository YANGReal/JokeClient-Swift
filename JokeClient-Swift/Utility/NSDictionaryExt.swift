//
//  NSDictionary-Null.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit
import Foundation
extension NSDictionary {
   
    
    func stringAttributeForKey(key:String)->String
    {
        //println(self[key])
        
        var obj:AnyObject?  = self[key]
        //if obj as! NSObject == NSNull()
        if let aa = obj as? NSObject
        {
            //return ""
        } else {
            return ""
        }
        if obj!.isKindOfClass(NSNumber)
        {
            var num = obj as! NSNumber
            return num.stringValue
        }
        if let bb = obj as? String
        {
            return obj as! String
        }
        return ""
    }
    
}
