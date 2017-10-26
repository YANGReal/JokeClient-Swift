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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // var uid = self.data["id"] as String
        let user = self.data["user"]
        
        if user as! NSObject != NSNull()
        {
            let userDict = user as! NSDictionary
            self.nickLabel!.text = userDict["login"] as! NSString as String
            
            let icon = userDict["icon"]
            if icon as! NSObject != NSNull()
            {
                let userIcon = icon as! String
                let userId =  userDict.stringAttributeForKey("id") as NSString;
                let prefixUserId = userId.substring(to: 3)
                let userImageURL = "http://pic.moumentei.com/system/avtnew/\(prefixUserId)/\(userId)/thumb/\(userIcon)"
                self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
            }
            else
            {
                self.avatarView!.image =  UIImage(named: "avatar.jpg")
            }
            
            let timeStamp = userDict.stringAttributeForKey("created_at")
            let date = timeStamp.dateStringFromTimestamp(timeStamp as NSString)
            self.dateLabel!.text = date
            
        }
        else
        {
            self.nickLabel!.text = "匿名"
            self.avatarView!.image =  UIImage(named: "avatar.jpg")
            self.dateLabel!.text = ""
            
        }
        let content = self.data.stringAttributeForKey("content")
        let width = UIScreen.main.bounds.size.height
        let height = content.stringHeightWith(17,width:width-10*2)
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        self.dateLabel!.setY(self.contentLabel!.bottom())
        let floor = self.data.stringAttributeForKey("floor")
        self.floorLabel!.text = "\(floor)楼"
//        self.contentLabel?.backgroundColor = UIColor.redColor();
    }

    
    
    
    
    class func cellHeightByData(_ data:NSDictionary)->CGFloat
    {
        let content = data.stringAttributeForKey("content")
        let width = UIScreen.main.bounds.size.height
        let height = content.stringHeightWith(17,width:width-10*2)
        return 53.0 + height + 24.0
    }

    
}
