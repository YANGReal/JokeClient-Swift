//
//  NSStringExtension.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-6.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//
import UIKit
import Foundation

extension String {
   

    func stringHeightWith(fontSize:CGFloat,width:CGFloat)->CGFloat

    {
        let font = UIFont.systemFontOfSize(fontSize)
        let size = CGSizeMake(width,CGFloat.max)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        let  attributes = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    func dateStringFromTimestamp(timeStamp:NSString)->String
    {
        let ts = timeStamp.doubleValue
        let  formatter = NSDateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        let date = NSDate(timeIntervalSince1970 : ts)
         return  formatter.stringFromDate(date)
        
    }
    
}
