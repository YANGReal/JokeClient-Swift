//
//  YRCommentsViewController.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-7.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit

class YRCommentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,YRRefreshViewDelegate {

    let identifier = "cell"
    var jokeType:YRJokeTableViewControllerType = .hotJoke
    var tableView:UITableView?
    var dataArray = NSMutableArray()
    var page :Int = 1
    var refreshView:YRRefreshView?
    var jokeId:String!

    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.title = "评论"
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func setupViews()
    {
        let width = UIScreen.main.bounds.size.width
        let height = self.view.frame.size.height
        self.tableView = UITableView(frame:CGRect(x: 0,y: 0,width: width,height: height))
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.none
        let nib = UINib(nibName:"YRCommnentsCell", bundle: nil)
        
        self.tableView?.register(nib, forCellReuseIdentifier: identifier)
        
        var arr =  Bundle.main.loadNibNamed("YRRefreshView" ,owner: self, options: nil)!
        self.refreshView = arr[0] as? YRRefreshView
        self.refreshView!.delegate = self
        
        self.tableView!.tableFooterView = self.refreshView
        self.view.addSubview(self.tableView!)
    }
    
    func loadData()
    {
        let url = "http://m2.qiushibaike.com/article/\(self.jokeId!)/comments?count=20&page=\(self.page)"
        self.refreshView!.startLoading()
        YRHttpRequest.requestWithURL(url,completionHandler:{ data in
            
            if data as! NSObject == NSNull()
            {
                UIView.showAlertView("提示",message:"加载失败")
                return
            }

            let arr = data["items"] as! NSArray
            if arr.count  == 0
            {
                UIView.showAlertView("提示",message:"暂无新评论哦")
                self.tableView!.tableFooterView = nil
            }
            for data in arr
            {
                self.dataArray.add(data)
            }
            self.tableView!.reloadData()
            self.refreshView!.stopLoading()
            self.page += 1
            })

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? YRCommnentsCell
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        cell!.data  = data
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let index = indexPath.row
        let data = self.dataArray[index] as! NSDictionary
        return  YRCommnentsCell.cellHeightByData(data)
    }
//    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
//    {
//        var index = indexPath!.row
//        var data = self.dataArray[index] as NSDictionary
//        println(data)
//    }
    
    func refreshView(_ refreshView:YRRefreshView,didClickButton btn:UIButton)
    {
        //refreshView.startLoading()
        loadData()
    }    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
