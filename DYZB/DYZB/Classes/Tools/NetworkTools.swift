//
//  NetworkTools.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/11.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}


class NetworkTools {
    class func requestData(type : MethodType, URLString : String, parameters : [String : NSString]? = nil, finishedCallback : (_ result : AnyObject) -> ()) {
        //1
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(method, URLString, parameters: parameters).responseJSON {
            
        
        }
    }
}
