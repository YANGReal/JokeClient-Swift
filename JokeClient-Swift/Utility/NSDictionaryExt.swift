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
        guard let obj = self[key] else {
            return ""
        }
        if let str = obj as? String
        {
            return str
        }
        else if let num = obj as? NSNumber
        {
            return num.stringValue
        }
        else
        {
            return ""
        }
    }
}
