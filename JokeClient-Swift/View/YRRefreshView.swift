//
//  YRRefreshView.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-6.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit



protocol YRRefreshViewDelegate 
{
    // @optional func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    
   func refreshView(_ refreshView:YRRefreshView,didClickButton btn:UIButton)
}


class YRRefreshView: UIView {

    @IBOutlet var button:UIButton!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBAction func buttonClicked(_ sender:UIButton)
    {
        self.delegate.refreshView(self,didClickButton:sender)
    }
    
    
    var delegate :YRRefreshViewDelegate!
    
       
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.indicator!.isHidden = true
        
    }
    
    func startLoading()
    {
        self.button!.setTitle("", for: UIControlState())
        self.indicator!.isHidden = false
        self.indicator!.startAnimating()
    }
    
    func stopLoading()
    {
        self.button!.setTitle("点击加载更多", for: UIControlState())
        self.indicator!.isHidden = true
        self.indicator!.stopAnimating()
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
