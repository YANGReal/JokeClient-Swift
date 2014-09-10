//
//  YRMainViewController.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class YRMainViewController: UITabBarController {

    var myTabbar :UIView?
    var slider :UIView?
    let btnBGColor:UIColor =  UIColor(red:125/255.0, green:236/255.0,blue:198/255.0,alpha: 1)
    let tabBarBGColor:UIColor =  UIColor(red:251/255.0, green:173/255.0,blue:69/255.0,alpha: 1)
    let titleColor:UIColor =  UIColor(red:52/255.0, green:156/255.0,blue:150/255.0,alpha: 1)
    
    
    let itemArray = ["最新","热门","真相","关于"]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "最新"
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        initViewControllers()
     //   loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupViews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBar.hidden = true
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.myTabbar = UIView(frame: CGRectMake(0,height-49,width,49))
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRectMake(0,0,80,49))
        self.slider!.backgroundColor = UIColor.whiteColor()//btnBGColor
        self.myTabbar!.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabbar!)
        
        var count = self.itemArray.count
        
         for var index = 0; index < count; index++
        {
            var btnWidth = (CGFloat)(index*80)
            var button  = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(btnWidth, 0,80,49)
            button.tag = index+100
            var title = self.itemArray[index]
            button.setTitle(title, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.setTitleColor(tabBarBGColor, forState: UIControlState.Selected)
            
            button.addTarget(self, action: "tabBarButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.selected = true
            }
        }
    }
    
    func initViewControllers()
    {
        var vc1 = YRJokeTableViewController()
        vc1.jokeType = .NewestJoke
        var vc2 = YRJokeTableViewController()
        vc2.jokeType = .HotJoke
        var vc3 = YRJokeTableViewController()
        vc3.jokeType = .ImageTruth
        var vc4 = YRAboutViewController(nibName: "YRAboutViewController", bundle: nil)
        self.viewControllers = [vc1,vc2,vc3,vc4]
    }
    
    
    func tabBarButtonClicked(sender:UIButton)
    {
        var index = sender.tag
        
        for var i = 0;i<4;i++
        {
            var button = self.view.viewWithTag(i+100) as UIButton
            if button.tag == index
            {
                button.selected = true
            }
            else
            {
                button.selected = false
            }
        }
        
        UIView.animateWithDuration( 0.3,
            {
           
            self.slider!.frame = CGRectMake(CGFloat(index-100)*80,0,80,49)
            
        })
        self.title = itemArray[index-100] as String
        self.selectedIndex = index-100
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
      //  UIView.animationw
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
