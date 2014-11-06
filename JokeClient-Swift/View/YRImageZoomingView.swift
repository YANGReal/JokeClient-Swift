//
//  YRImageZoomingVIew.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class YRImageZoomingView: UIScrollView,UIScrollViewDelegate {

    
    var imageView:UIImageView?
    var imageURL:String!
    let placeHolder:UIImage = UIImage(named:"avatar.jpg")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.delegate = self
        
        
        self.imageView = UIImageView(frame:self.bounds)
        self.imageView!.contentMode = .ScaleAspectFit
        self.addSubview(self.imageView!)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = UIColor.clearColor()
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 3;
     
        var doubleTap = UITapGestureRecognizer(target: self, action: "doubleTapped:")
        doubleTap.numberOfTapsRequired = 2;
        self.addGestureRecognizer(doubleTap);
        
    }

    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func doubleTapped(sender:UITapGestureRecognizer)
    {
        if self.zoomScale > 1.0
        {
            self.setZoomScale(1.0, animated:true);
        }
        else
        {
            var point = sender.locationInView(self);
            self.zoomToRect(CGRectMake(point.x-50, point.y-50, 100, 100), animated:true)
        }

    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!)->UIView
    {
        return self.imageView!
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.imageView!.setImage(self.imageURL,placeHolder:placeHolder)
        
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
