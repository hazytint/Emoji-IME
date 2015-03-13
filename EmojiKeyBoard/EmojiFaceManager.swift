//
//  EmojiFaceManager.swift
//  Emoji-IME
//
//  Created by Wuhua Dai on 15/3/5.
//  Copyright (c) 2015年 wua. All rights reserved.
//

import UIKit

private let sharedInstance = EmojiFaceManager()

class EmojiFaceManager: NSObject {
    class var sharedManager: EmojiFaceManager {
        return sharedInstance
    }
    
    private let faceDict = [
        "Keys": ["卖萌","开心","快乐","悲伤","愤怒","不快","讨厌","自定义"],
        "卖萌": ["(>ω<)","(^u^)",""],
        "开心": ["(^ω^)","(^o^)","^_^","(-_-)","COC"],
        "快乐": [">1<","OvO","QxQ","(-_-)","(W_W)"],
        "悲伤": [">2<","OvO","QxQ","(-_-)","TAT"],
        "愤怒": [">3<","OvO","QxQ","(-_-)","TOT"],
        "不快": [">4<","OvO","QxQ","(-_-)","TXT"],
        "讨厌": [">5<","OvO","QxQ","(-_-)","QOQ"],
        "自定义": [">6<","OvO","QxQ","(-_-)","LoL"],
    ]
    
    private var emojiFaceDict: [String:[String]]!
    
    override init() {
        super.init()
        loadEmojiFaceFromFileIfNeed()
    }
    
    private func loadEmojiFaceFromFileIfNeed() {
        var userDefault = NSUserDefaults.standardUserDefaults()
        let tmpDict = userDefault.dictionaryForKey("EmojiFace") as [String:[String]]?
        if tmpDict == nil {
           userDefault.setObject(faceDict, forKey: "EmojiFace")
            emojiFaceDict = faceDict
        }
        else {
            emojiFaceDict = tmpDict!
        }
    }
    
    var emojiCategoryTitles: [String] {
        get{
            return emojiFaceDict["Keys"]!
        }
    }
    
    func getFaceswithCatagoryTitle(title: String?) -> [String] {
        if title == nil {
            return []
        }
        let rtn = emojiFaceDict[title!] as [String]?
        if rtn == nil {
            return []
        }
        return rtn!
    }
}
