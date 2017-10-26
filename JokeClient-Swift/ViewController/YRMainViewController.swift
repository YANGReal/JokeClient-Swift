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
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "最新"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        initViewControllers()
    }
    
    func setupViews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.tabBar.isHidden = true
        let width = UIScreen.main.bounds.size.width;
        let height = self.view.frame.size.height
        self.myTabbar = UIView(frame: CGRect(x: 0,y: height-49,width: width,height: 49))
        self.myTabbar!.backgroundColor = tabBarBGColor
        self.slider = UIView(frame:CGRect(x: 0,y: 0,width: 80,height: 49))
        self.slider!.backgroundColor = UIColor.white//btnBGColor
        self.myTabbar!.addSubview(self.slider!)
        
        self.view.addSubview(self.myTabbar!)
        
        let count = self.itemArray.count
        
         for index in 0 ..< count
        {
            
            let btnWidth = (CGFloat)(width/4)
            let button  = UIButton(type: UIButtonType.custom)
            let x = (btnWidth*(CGFloat)(index));
            button.frame = CGRect(x: x, y: 0,width: btnWidth,height: 49)
            button.tag = index+100
            let title = self.itemArray[index]
            button.setTitle(title, for: UIControlState())
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.setTitleColor(tabBarBGColor, for: UIControlState.selected)
            
            button.addTarget(self, action: #selector(YRMainViewController.tabBarButtonClicked(_:)), for: UIControlEvents.touchUpInside)
            self.myTabbar?.addSubview(button)
            if index == 0
            {
                button.isSelected = true
            }
        }
    }
    
    func initViewControllers()
    {
        let vc1 = YRJokeTableViewController()
        vc1.jokeType = .newestJoke
        let vc2 = YRJokeTableViewController()
        vc2.jokeType = .hotJoke
        let vc3 = YRJokeTableViewController()
        vc3.jokeType = .imageTruth
        let vc4 = YRAboutViewController(nibName: "YRAboutViewController", bundle: nil)
        self.viewControllers = [vc1,vc2,vc3,vc4]
    }
    
    
    func tabBarButtonClicked(_ sender:UIButton)
    {
        let index = sender.tag
        
        for i in 0 ..< 4
        {
            let button = self.view.viewWithTag(i+100) as! UIButton
            if button.tag == index
            {
                button.isSelected = true
            }
            else
            {
                button.isSelected = false
            }
        }
        let width = UIScreen.main.bounds.size.width;
        let btnWidth = (CGFloat)(width/4)
        UIView.animate( withDuration: 0.3,
            animations:{
           
            self.slider!.frame = CGRect(x: CGFloat(index-100)*btnWidth,y: 0,width: btnWidth,height: 49)
            
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
