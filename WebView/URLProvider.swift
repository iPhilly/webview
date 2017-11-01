//
//  URLProvider.swift
//  WebView
//
//  Created by toonan on 2017/11/1.
//  Copyright © 2017年 leophy. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public func setLocalUrl(_ url: URL) {
    UserDefaults.standard.set(url, forKey: "localurl")
}

public func getLocalUrl() -> URL {
    return UserDefaults.standard.url(forKey: "localurl") ?? URL(string:"http://83337.com")!
}

public func getRemoteUrl(completion:@escaping ((URL) -> Void)) {
    
    Alamofire.request("http://120.78.159.110:8888/getUrl").responseJSON { (dataResponse) in
        
        switch dataResponse.result {
        case .success(let value) :
            
            guard let jsonValue = value as? [String: String] else {
                completion(getLocalUrl())
                return
            }
            
            let urlStr = jsonValue["url"]!
            let urlString = urlStr.hasPrefix("http") ? urlStr : "http://".appending(urlStr)
            guard let url = URL(string:urlString) else {
                completion(getLocalUrl())
                return
            }
            
            setLocalUrl(url)
            
            print("url")
            print(url)
            completion(url)
            
            break
        case .failure(let error) :
            completion(getLocalUrl())
            debugPrint(error)
        }
    }
}
