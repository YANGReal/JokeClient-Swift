//
//  YRJokeTableViewController.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit


enum YRJokeTableViewControllerType : Int {
    case hotJoke
    case newestJoke
    case imageTruth
    
}

class  YRJokeTableViewController:UIViewController,YRRefreshViewDelegate,UITableViewDelegate,UITableViewDataSource

{
    
    let identifier = "YRJokeCellIdentifier"
    var jokeType:YRJokeTableViewControllerType = .hotJoke
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
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
          NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "imageViewTapped"), object:nil)
        
    }
     override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector: #selector(YRJokeTableViewController.imageViewTapped(_:)), name: NSNotification.Name(rawValue: "imageViewTapped"), object: nil)
    }
    
    
    
    func setupViews()
    {
        let width = UIScreen.main.bounds.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRect(x: 0,y: 64,width: width,height: height-49-64))
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        let nib = UINib(nibName:"YRJokeCell", bundle: nil)
       
        self.tableView?.register(nib, forCellReuseIdentifier: identifier)
        var arr =  Bundle.main.loadNibNamed("YRRefreshView" ,owner: self, options: nil)!
        self.refreshView = arr[0] as? YRRefreshView
        self.refreshView!.delegate = self

        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView!)
    }
    
    
    func loadData()
    {
        let url = urlString()
        self.refreshView!.startLoading()
        YRHttpRequest.requestWithURL(url,completionHandler:{ data in
           
            if data as! NSObject == NSNull()
            {
               UIView.showAlertView("提示",message:"加载失败")
              return
            }
            
            let arr = data["items"] as! NSArray
            //println(data)
            for data in arr
            {
               self.dataArray.add(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page += 1;
            })
    }
    
    
    func urlString()->String
    {
        if jokeType == .hotJoke //最热糗事
        {
            return "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
        }
        else if jokeType == .newestJoke //最新糗事
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

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.dataArray.count;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? YRJokeCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell!.data = data
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        return  YRJokeCell.cellHeightByData(data)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        let commentsVC = YRCommentsViewController(nibName :nil, bundle: nil)
        commentsVC.jokeId = data.stringAttributeForKey("id")
        self.navigationController!.pushViewController(commentsVC, animated: true)
    }
    
     func refreshView(_ refreshView:YRRefreshView,didClickButton btn:UIButton)
     {
        loadData()
     }
    
    func imageViewTapped(_ noti:Notification)
    {
        
        let imageURL = noti.object as! String
        let imgVC = YRImageViewController(nibName: nil, bundle: nil)
        imgVC.imageURL = imageURL
        self.navigationController!.pushViewController(imgVC, animated: true)
        
       
    }
    
}
