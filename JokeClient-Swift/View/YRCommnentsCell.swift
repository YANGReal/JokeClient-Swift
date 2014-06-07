//
//  YRCommnentsCell.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class YRCommnentsCell: UITableViewCell {

    
    @IBOutlet var avatarView:UIImageView?
    @IBOutlet var nickLabel:UILabel?
    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var floorLabel:UILabel?
    @IBOutlet var dateLabel:UILabel?
   
  
    var data :NSDictionary!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // var uid = self.data["id"] as String
        var user : AnyObject!  = self.data["user"]
        
        if user as NSObject != NSNull()
        {
            var userDict = user as NSDictionary
            self.nickLabel!.text = userDict["login"] as NSString
            
            var icon : AnyObject! = userDict["icon"]
            if icon as NSObject != NSNull()
            {
                var userIcon = icon as String
                var userId =  userDict["id"] as NSString
                var prefixUserId = userId.substringToIndex(3)
                var userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
            }
            else
            {
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
            }
            
            var timeStamp = userDict.stringAttributeForKey("created_at")
            var date = timeStamp.dateStringFromTimestamp(timeStamp)
            self.dateLabel!.text = date
            
        }
        else
        {
            self.nickLabel!.text = "匿名"
            self.avatarView!.image =  UIImage(named: "avatar.jpg")
            self.dateLabel!.text = ""
            
        }
        var content = self.data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17,width:300)
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        self.dateLabel!.setY(self.contentLabel!.bottom())
        var floor = self.data.stringAttributeForKey("floor")
        self.floorLabel!.text = "\(floor)楼"
    }

    
    
    
    
    class func cellHeightByData(data:NSDictionary)->CGFloat
    {
        var content = data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17,width:300)
        return 53.0 + height + 24.0
    }

    
}
