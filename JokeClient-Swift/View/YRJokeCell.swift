//
//  YRJokeCell.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-6.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit


class YRJokeCell: UITableViewCell {

    @IBOutlet var avatarView:UIImageView?
    @IBOutlet var pictureView:UIImageView?
    @IBOutlet var nickLabel:UILabel?
    @IBOutlet var contentLabel:UILabel?
    @IBOutlet var likeLabel:UILabel?
    @IBOutlet var dislikeLabel:UILabel?
    @IBOutlet var commentLabel:UILabel?
    @IBOutlet var bottomView:UIView?
    var largeImageURL:String = ""
    var data :NSDictionary!
    
    //let avatarPlaceHolder = UIImage(named: "avatar.jpg")
    
    @IBAction func shareBtnClicked()
    {
       // self.delegate!.jokeCell(self, didClickShareButtonWithData:self.data)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
         self.selectionStyle = .None
        
        
        var tap = UITapGestureRecognizer(target: self, action: "imageViewTapped:")
        self.pictureView!.addGestureRecognizer(tap)
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
            
            var icon : AnyObject! = userDict["icon"] //as NSString
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
        }
        else
        {
            self.nickLabel!.text = "匿名"
            self.avatarView!.image =  UIImage(named: "avatar.jpg")
          
        }
        var content = self.data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17,width:300)
       
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        
        var imgSrc = self.data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            self.pictureView!.hidden = true
            self.bottomView!.setY(self.contentLabel!.bottom())
        }
        else
        {
            var imageId = self.data.stringAttributeForKey("id") as NSString
            var prefiximageId = imageId.substringToIndex(4)
            var imagURL = "http://pic.moumentei.com/system/pictures/\(prefiximageId)/\(imageId)/small/\(imgSrc)"
            self.pictureView!.hidden = false
            self.pictureView!.setImage(imagURL,placeHolder: UIImage(named: "avatar.jpg"))
            self.largeImageURL = "http://pic.moumentei.com/system/pictures/\(prefiximageId)/\(imageId)/medium/\(imgSrc)"
            self.pictureView!.setY(self.contentLabel!.bottom()+5)
            self.bottomView!.setY(self.pictureView!.bottom())
        }
        
        var votes :AnyObject!  = self.data["votes"]
        if votes as NSObject == NSNull()
        {
            self.likeLabel!.text = "顶(0)"
            self.dislikeLabel!.text = "踩(0)"
           // self.likeLabel!.text = "评论(0)"
        }
        else
        {
            var votesDict = votes as NSDictionary
            var like  = votesDict.stringAttributeForKey("up") as String
            var disLike  = votesDict.stringAttributeForKey("down") as String
            self.likeLabel!.text = "顶(\(like))"
            self.dislikeLabel!.text = "踩(\(disLike))"
        }//comments_count
        var commentCount = self.data.stringAttributeForKey("comments_count") as String
        self.commentLabel!.text = "评论(\(commentCount))"
        
        
        
        
    }
    
    
    class func cellHeightByData(data:NSDictionary)->CGFloat
    {
        var content = data.stringAttributeForKey("content")
        var height = content.stringHeightWith(17,width:300)
        var imgSrc = data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            return 59+height+40
        }
        return 59+height+5+112+40
    }
    
    func imageViewTapped(sender:UITapGestureRecognizer)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("imageViewTapped", object:self.largeImageURL)

    }
    
    
    
}
