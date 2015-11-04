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
        
        
        let tap = UITapGestureRecognizer(target: self, action: "imageViewTapped:")
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
        
                
        let user:AnyObject?  = self.data["user"]
        
        //if user as! NSObject != NSNull()
        if let userDictOp:NSDictionary = user as? NSDictionary
        {
            //var userDict = user as! NSDictionary
            let userDict = userDictOp
            self.nickLabel!.text = userDict["login"] as! String?
            
            let icon : AnyObject! = userDict["icon"] //as NSString
            if icon as! NSObject != NSNull()
            {
                let userIcon = icon as! String
                let userId =  userDict["id"] as! NSString
                let prefixUserId = userId.substringToIndex(userId.length - 4)
                
                let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserId)/\(userId)/medium/\(userIcon)"
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
        let content = self.data.stringAttributeForKey("content")
        let height = content.stringHeightWith(17,width:300)
       
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        
        let imgSrc = self.data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            self.pictureView!.hidden = true
            self.bottomView!.setY(self.contentLabel!.bottom())
        }
        else
        {
            let imageId = self.data.stringAttributeForKey("id") as NSString
            let prefiximageId = imageId.substringToIndex(imageId.length - 4)
            let imagURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/small/\(imgSrc)"
            self.pictureView!.hidden = false
            self.pictureView!.setImage(imagURL,placeHolder: UIImage(named: "avatar.jpg"))
            self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/medium/\(imgSrc)"
            self.pictureView!.setY(self.contentLabel!.bottom()+5)
            self.bottomView!.setY(self.pictureView!.bottom())
        }
        
        let votes :AnyObject!  = self.data["votes"]
        if votes as! NSObject == NSNull()
        {
            self.likeLabel!.text = "顶(0)"
            self.dislikeLabel!.text = "踩(0)"
           // self.likeLabel!.text = "评论(0)"
        }
        else
        {
            let votesDict = votes as! NSDictionary
            let like  = votesDict.stringAttributeForKey("up") as String
            let disLike  = votesDict.stringAttributeForKey("down") as String
            self.likeLabel!.text = "顶(\(like))"
            self.dislikeLabel!.text = "踩(\(disLike))"
        }//comments_count
        let commentCount = self.data.stringAttributeForKey("comments_count") as String
        self.commentLabel!.text = "评论(\(commentCount))"
        
        
        
        
    }
    
    
    class func cellHeightByData(data:NSDictionary)->CGFloat
    {
        let content = data.stringAttributeForKey("content")
        let height = content.stringHeightWith(17,width:300)
        let imgSrc = data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            return 59.0 + height + 40.0
        }
        return 59.0 + height + 5.0 + 112.0 + 40.0
    }
    
    func imageViewTapped(sender:UITapGestureRecognizer)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("imageViewTapped", object:self.largeImageURL)

    }
    
    
    
}
