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
        var obj : AnyObject! = self[key]
        if obj as NSObject == NSNull()
        {
            return ""
        }
        if obj.isKindOfClass(NSNumber)
        {
            var num = obj as NSNumber
            return num.stringValue
        }
       return obj as String
    }
    
}
