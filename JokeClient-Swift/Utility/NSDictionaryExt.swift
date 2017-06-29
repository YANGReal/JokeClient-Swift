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
   
    
    func stringAttributeForKey(_ key:String)->String
    {
        //println(self[key])
        
        let obj = self[key] as AnyObject?
        //if obj as! NSObject == NSNull()
        if let _ = obj as? NSObject
        {
            //return ""
        } else {
            return ""
        }
        if obj!.isKind(of: NSNumber.self)
        {
            let num = obj as! NSNumber
            return num.stringValue
        }
        if let _ = obj as? String
        {
            return obj as! String
        }
        return ""
    }
    
}
