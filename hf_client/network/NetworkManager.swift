//
//  NetworkManager.swift
//  hf_client
//
//  Created by Roman Figurin on 26/11/2017.
//  Copyright © 2017 Roman Figurin. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    class func makeGetCall() {
        // Set up the URL request
        let todoEndpoint: String = "http://172.16.2.171:3000/supply_contract"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                let dataStr: String = String(data: responseData, encoding: String.Encoding.utf8) as String!
                print("dataStr: " + dataStr)
                
                let dataDict: [String: Any] = convertToDictionary(text: dataStr)!
                let stateStr: String = dataDict["state"] as! String
                print("dataDict[state] = " + stateStr)
                
                if stateStr == "damaged" {
                    NotificationCenter.default.post(name: .damaged, object: nil)
                }
                else {
                    NotificationCenter.default.post(name: .ok, object: nil)
                }
                

            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

