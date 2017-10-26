//
//  UIView-Frame.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit
import Foundation
extension UIView  {
   
    func x()->CGFloat
    {
        return self.frame.origin.x
    }
    func right()-> CGFloat
    {
        return self.frame.origin.x + self.frame.size.width
    }
    func y()->CGFloat
    {
        return self.frame.origin.y
    }
    func bottom()->CGFloat
    {
        return self.frame.origin.y + self.frame.size.height
    }
    func width()->CGFloat
    {
        return self.frame.size.width
    }
    func height()-> CGFloat
    {
        return self.frame.size.height
    }
    
    func setX(_ x: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = x
        self.frame = rect
    }
    
    func setRight(_ right: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.x = right - rect.size.width
        self.frame = rect
    }
    
    func setY(_ y: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = y
        self.frame = rect
    }
    
    func setBottom(_ bottom: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.origin.y = bottom - rect.size.height
        self.frame = rect
    }
    
    func setWidth(_ width: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.width = width
        self.frame = rect
    }
    
    func setHeight(_ height: CGFloat)
    {
        var rect:CGRect = self.frame
        rect.size.height = height
        self.frame = rect
    }
    
    class func showAlertView(_ title:String,message:String)
    {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: "好")
        alert.show()

    }
    
    
}
