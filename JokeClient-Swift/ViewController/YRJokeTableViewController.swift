//
//  YRJokeTableViewController.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit


enum YRJokeTableViewControllerType : Int {
    case HotJoke
    case NewestJoke
    case ImageTruth
    
}

class YRJokeTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,YRRefreshViewDelegate{
    
    let identifier = "cell"
    var jokeType:YRJokeTableViewControllerType = .HotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:YRRefreshView?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
        loadData()
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
          NSNotificationCenter.defaultCenter().removeObserver(self, name: "imageViewTapped", object:nil)
        
    }
     override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageViewTapped:", name: "imageViewTapped", object: nil)
    }
    
    
    
    func setupViews()
    {
        var width = self.view.frame.size.width
        var height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRectMake(0,64,width,height-49-64))
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        var nib = UINib(nibName:"YRJokeCell", bundle: nil)
       
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)
       // self.tableView?.registerClass(YRJokeCell.self,
        //forCellReuseIdentifier: identifier)
        var arr =  NSBundle.mainBundle().loadNibNamed("YRRefreshView" ,owner: self, options: nil) as Array
        self.refreshView = arr[0] as? YRRefreshView
        self.refreshView!.delegate = self

        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView)
    }
    
    
    func loadData()
    {
        var url = urlString()
        self.refreshView!.startLoading()
        YRHttpRequest.requestWithURL(url,completionHandler:{ data in
           
            if data as NSObject == NSNull()
            {
               UIView.showAlertView("提示",message:"加载失败")
              return
            }
            
            var arr = data["items"] as NSArray
            
            for data : AnyObject  in arr
            {
               self.dataArray.addObject(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page++
            })
    }
    
    
    func urlString()->String
    {
        if jokeType == .HotJoke //最热糗事
        {
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        }
        else if jokeType == .NewestJoke //最新糗事
        {
           return "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
        }
        else//有图有真相
        {
            return "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.dataArray.count
    }

    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        
        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? YRJokeCell
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        cell!.data = data
        return cell
    }
    
     func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
     {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        return  YRJokeCell.cellHeightByData(data)
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
        var commentsVC = YRCommentsViewController(nibName :nil, bundle: nil)
        commentsVC.jokeId = data.stringAttributeForKey("id")
        self.navigationController.pushViewController(commentsVC, animated: true)
    }
    
     func refreshView(refreshView:YRRefreshView,didClickButton btn:UIButton)
     {
        //refreshView.startLoading()
        loadData()
     }
    
    func imageViewTapped(noti:NSNotification)
    {
        
        var imageURL = noti.object as String
        var imgVC = YRImageViewController(nibName: nil, bundle: nil)
        imgVC.imageURL = imageURL
        self.navigationController.pushViewController(imgVC, animated: true)
        
       
    }
    
}
