//
//  UIImageViewWebExt.swift
//  JokeClient-Swift
//
//  Created by YANGReal on 14-6-5.
//  Copyright (c) 2014年 YANGReal. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView
{
    func setImage(_ urlString:String,placeHolder:UIImage!)
    {
    
        let url = URL(string: urlString)
        let cacheFilename = url!.lastPathComponent
        let cachePath = FileUtility.cachePath(cacheFilename!)
        let image : AnyObject = FileUtility.imageDataFromPath(cachePath)
      //  println(cachePath)
        if image as! NSObject != NSNull()
        {
            self.image = image as? UIImage
        }
        else
        {
            let req = URLRequest(url: url!)
            let queue = OperationQueue();
            NSURLConnection.sendAsynchronousRequest(req, queue: queue, completionHandler: { response, data, error in
                if (error != nil)
                {
                    DispatchQueue.main.async(execute: {
                            print(error)
                            self.image = placeHolder
                        })
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                            
                            let image = UIImage(data: data!)
                            if (image == nil)
                            {

                                print("image is nil and url fail=\(urlString)")
                                self.image = placeHolder
                            }
                            else
                            {
                                self.image = image
                                let bIsSuccess = FileUtility.imageCacheToPath(cachePath,image:data!)
                                if !bIsSuccess
                                {
                                    print("*******cache fail,path=\(cachePath)")
                                }
                            }
                        })
                }
                })

        }
        
    }
}


