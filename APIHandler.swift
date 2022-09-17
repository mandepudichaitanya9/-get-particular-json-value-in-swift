//
//  APIHandler.swift
//  PractiseAPI
//
//  Created by chaitanya on 17/09/22.
//
// array inside Objects unte e format lo rastam
// array inside multiple objects unte post api method lo unnattu ga rastam



import UIKit
import Alamofire


class APIHandler:NSObject {
    
    
// [ {
//    "userId": 1,
//    "id": 1,
//   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    "Data":{4 values}
//  }]

    
    func apiPostCall( handler: @escaping (_ result: NSDictionary) -> (Void) ) {
    let url = "https://trains.p.rapidapi.com/"
    
    let headers:HTTPHeaders = [
            "content-type": "application/json",
            "X-RapidAPI-Key": "00ab76053cmshfb85d0da8ddbadcp1bb580jsn5e5e619aa0e0",
            "X-RapidAPI-Host": "trains.p.rapidapi.com"
         ]
    var parameters =  [String:String]()
        parameters  = ["search": "Rajdhani"]
    
    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers).response { response in
        
        switch response.result {
        case .success(_):
            do {
                if let data = response.data {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String:Any]] {
                        for item in json {
                            if let name = item["data"] as? [String:Any] {
                                let time = name["arriveTime"]
                                print(time ?? "")
                                
                            }
                            
                        }
                    }
                }
                }
            catch {
                
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
        
    }
    
    
    }
    
    // MARK: - JSON Model
    
// [ {
//    "userId": 1,
//    "id": 1,
//   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//  }]

    func getAPICall( handler: @escaping (_ title:String, _ body:String) -> (Void)) {
        
        let url = "https://jsonplaceholder.typicode.com/posts/"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response { responce in
            switch responce.result {
            case .success(_):
                do {
                if let data = responce.data {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String:Any]] {
                        for item in json {
                            if let titles = item["title"], let body = item["body"] {
                                handler(titles as! String, body as! String)
                            }
                        }
                    }
                }
                }catch {
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
        
    }
    
    
}
