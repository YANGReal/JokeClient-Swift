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
       
         self.selectionStyle = .none
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(YRJokeCell.imageViewTapped(_:)))
        self.pictureView!.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        // var uid = self.data["id"] as String
        
        guard ((self.data) != nil) else{
            return;
        }
        
        let user  = self.data["user"]
        
        //if user as! NSObject != NSNull()
        if let userDictOp:NSDictionary = user as? NSDictionary
        {
            //var userDict = user as! NSDictionary
            let userDict = userDictOp
            self.nickLabel!.text = userDict["login"] as! String?
            
            let icon = userDict["icon"] //as NSString
            if icon as! NSObject != NSNull()
            {
                let userIcon = icon as! String
                if let idNumber = userDict["id"] as? NSNumber {
                    let userId = idNumber.stringValue as NSString
                    let prefixUserId = userId.substring(to: userId.length - 4)
                    
                    let userImageURL = "http://pic.qiushibaike.com/system/avtnew/\(prefixUserId)/\(userId)/medium/\(userIcon)"
                    self.avatarView!.setImage(userImageURL,placeHolder: UIImage(named: "avatar.jpg"))
                }
                
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
         let width = UIScreen.main.bounds.size.width;
        let height = content.stringHeightWith(17,width:width-10*2)
       
        self.contentLabel!.setHeight(height)
        self.contentLabel!.text = content
        
        let imgSrc = self.data.stringAttributeForKey("image") as NSString
        if imgSrc.length == 0
        {
            self.pictureView!.isHidden = true
            self.bottomView!.setY(self.contentLabel!.bottom())
        }
        else
        {
            let imageId = self.data.stringAttributeForKey("id") as NSString
            let prefiximageId = imageId.substring(to: imageId.length - 4)
            let imagURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/small/\(imgSrc)"
            self.pictureView!.isHidden = false
            self.pictureView!.setImage(imagURL,placeHolder: UIImage(named: "avatar.jpg"))
            self.largeImageURL = "http://pic.qiushibaike.com/system/pictures/\(prefiximageId)/\(imageId)/medium/\(imgSrc)"
            self.pictureView!.setY(self.contentLabel!.bottom()+5)
            self.bottomView!.setY(self.pictureView!.bottom())
        }
        
        if let votesDict = self.data["votes"] as? NSDictionary
        {
            let like  = votesDict.stringAttributeForKey("up")
            let disLike  = votesDict.stringAttributeForKey("down")
            self.likeLabel!.text = "顶(\(like))"
            self.dislikeLabel!.text = "踩(\(disLike))"
        }
        else
        {
            self.likeLabel!.text = "顶(0)"
            self.dislikeLabel!.text = "踩(0)"
            // self.likeLabel!.text = "评论(0)"
        }//comments_count
        let commentCount = self.data.stringAttributeForKey("comments_count")
        self.commentLabel!.text = "评论(\(commentCount))"

    }
    
    
    class func cellHeightByData(_ data:NSDictionary)->CGFloat
    {
        let width = UIScreen.main.bounds.size.width;
        let content = data.stringAttributeForKey("content")
        let height = content.stringHeightWith(17,width:width-10*2)
        let imgSrc = data.stringAttributeForKey("image")
        if imgSrc.isEmpty
        {
            return 59.0 + height + 40.0
        }
        return 59.0 + height + 5.0 + 112.0 + 40.0
    }
    
    func imageViewTapped(_ sender:UITapGestureRecognizer)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "imageViewTapped"), object:self.largeImageURL)

    }
    
    
    
}
