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
   
    func stringHeightWith(fontSize:Float,width:Float)->Float
    {
        var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(width,CGFLOAT_MAX)
       // var attr = [font:NSFontAttributeName]
      

        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        var  attributes = [NSFontAttributeName:font,
            NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var text = self as NSString
        var rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
      
        return rect.size.height
        
    }
    
    func dateStringFromTimestamp(timeStamp:NSString)->String
    {
        var ts = timeStamp.doubleValue
        
        //var date = NSDate.timeIntervalSince1970: NSTimeInterval { get }
        var  formatter = NSDateFormatter ()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
//        var date = formatter.dateFromString(timeStamp)
//        println(date)
//        return "2014-01-01"
//       // return formatter.stringFromDate(date)
//        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1296035591];
//        NSLog(@"1296035591  = %@",confromTimesp);
//        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//        NSLog(@"confromTimespStr =  %@",confromTimespStr);
        
        var date = NSDate(timeIntervalSince1970 : ts)
         return  formatter.stringFromDate(date)
        
    }
    
}
