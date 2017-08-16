//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by guo xiaofei on 2017/8/14.
//  Copyright © 2017年 guo xiaofei. All rights reserved.
//

import UIKit
import HandyJSON

class RecommendViewModel {

    lazy var ancnorGroups : [AncnorGroup] = [AncnorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AncnorGroup = AncnorGroup()
    fileprivate lazy var verticalGroup : AncnorGroup = AncnorGroup()
}


//
extension RecommendViewModel{
    func requestData(finishCallback : @escaping () -> ())  {
        //0 
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        
        let Dgroup = DispatchGroup()
        
        //1 推荐数据
        Dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
            //1
            guard let resultDict = result as? [String : NSObject] else { return }
            let dataArray = resultDict["data"]
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            let ancnorModels = JSONDeserializer<AncnorModel>.deserializeModelArrayFrom(array: dataArray as? NSArray)! as! [AncnorModel]
            self.bigDataGroup.room_list = ancnorModels
            
            Dgroup.leave()
        }
        
        //2 颜值数据
        Dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //1
            guard let resultDict = result as? [String : NSObject] else { return }
            let dataArray = resultDict["data"]
            
            self.verticalGroup.tag_name = "颜值"
            self.verticalGroup.icon_name = "home_header_phone"
            
            let ancnorModels = JSONDeserializer<AncnorModel>.deserializeModelArrayFrom(array: dataArray as? NSArray)! as! [AncnorModel]
            self.verticalGroup.room_list = ancnorModels
            Dgroup.leave()
            
        }
        
        //3 后面部分游戏数据
        Dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //1
            guard let resultDict = result as? [String : NSObject] else { return }
            let dataArray = resultDict["data"]
            
            self.ancnorGroups = JSONDeserializer<AncnorGroup>.deserializeModelArrayFrom(array: dataArray as? NSArray)! as! [AncnorGroup]
            Dgroup.leave()
            
        }
        
        Dgroup.notify(queue: DispatchQueue.main) { 
            self.ancnorGroups.insert(self.verticalGroup, at: 0)
            self.ancnorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
       
    }
    
    
    func  requestCycleData(finishCallback : @escaping () -> ()){
        
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            //1
            guard let resultDict = result as? [String : NSObject] else { return }
            let dataArray = resultDict["data"]
            
            self.cycleModels = JSONDeserializer<CycleModel>.deserializeModelArrayFrom(array: dataArray as? NSArray)! as! [CycleModel]
            
            
            finishCallback()
        }
    
    }
    
   

}
