//
//  SignUp.swift
//  FoodTracker
//
//  Created by Chris Dean on 2018-03-26.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation

class RequestManager {
    
    //andCompletionHandler:(void(^)(NSData *data, UIImage *image))completionHandler
    
    func login(userName: String?, password: String?, completionHandler: @escaping ((String?, String?)) -> Void) {
        
        let postData = [
            "username": userName ?? "",
            "password": password ?? ""
        ]
        
        guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
            print("could not serialize JSON")
            return
        }
        
        let urlString = URL(string: "https://cloud-tracker.herokuapp.com/login")
        let request = NSMutableURLRequest(url: urlString!)
        request.httpBody = postJSON
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                print("Received error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data is not json")
                return
            }
            
            //let token = json["token"]
            let responseTuple = (token: json["token"] as? String, error: json["error"] as? String)
            completionHandler(responseTuple)
            
            guard let response = response as? HTTPURLResponse else {
                print("no response returned from server \(String(describing: error))")
                return
            }
            
            guard response.statusCode == 200 else {
                // handle error
                print("an error occurred \(String(describing: json["error"]))")
                return
            }
        }
        dataTask.resume()
        
        
    }
    
    func signUp(userName: String?, password: String?, completionHandler: @escaping ((String?, String?)) -> Void) {
        
        let postData = [
            "username": userName ?? "",
            "password": password ?? ""
        ]
        
        guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
            print("could not serialize JSON")
            return
        }
        
        let urlString = URL(string: "https://cloud-tracker.herokuapp.com/signup")
        let request = NSMutableURLRequest(url: urlString!)
        request.httpBody = postJSON
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                print("Received error: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data is not json")
                return
            }
            
//            let token = json["token"]
//            let error = json["error"]
//            completionHandler(token as! String)
            
            let responseTuple = (token: json["token"] as? String, error: json["error"] as? String)
            completionHandler(responseTuple)
            
            
            guard let response = response as? HTTPURLResponse else {
                print("no response returned from server \(String(describing: error))")
                return
            }
            
            guard response.statusCode == 200 else {
                // handle error
                print("an error occurred \(String(describing: json["error"]))")
                return
            }
        }
        dataTask.resume()
        
        
    }
}
