//
//  APIService.swift
//  binet-task
//
//  Created by Maksim Nosov on 23/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    //    func getSessionId(requestUrl: String, token: String, completionHandlerForSessionId: @escaping (_ result: Decodable?, _ error: Error?) -> Void)
}

class APIService: APIServiceProtocol {
    
    private let authManager: AuthenticationManagerProtocol!
    
    init(authManager: AuthenticationManagerProtocol) {
        self.authManager = authManager
    }
    
    // new_session - Получение новой session
    func getSessionId(requestUrl: String, token: String, completionHandlerForSessionId: @escaping (_ result: Session?, _ error: Error?) -> Void) {
        
        let parameters = [
            "a": Constants.newSession
            ] as [String : Any]
        
        print(parameters)
        
        taskForPOSTMethod(requestURL: requestUrl, parameters: parameters) { (result: Session?, error: Error?) in
            if let error = error {
                completionHandlerForSessionId(nil, error)
            } else {
                    completionHandlerForSessionId(result, nil)
            }
        }
    }
    
    // add_entry - Отправка данных на сервер
    func addEntry(requestUrl: String, body: String, sessionId: String, token: String, completionHandlerForAddEntry: @escaping (_ result: EntryResponse?, _ error: Error?) -> Void) {
        
        let parameters = [
            "a": "add_entry",
            "session": "XHGpQZg9J0aG1fhtFy",
            "body": "body sdfadsaf"
            ] as [String : String]
        
        taskForPOSTMethod(requestURL: requestUrl, parameters: parameters) { (result: EntryResponse?, error: Error?) in
            if let error = error {
                completionHandlerForAddEntry(nil, error)
            } else {
                completionHandlerForAddEntry(result, nil)
            }
        }
    }
    
    // get_entries - Получение данных с сервера
        func getEntries(requestUrl: String, sessionId: String, completionHandlerForAddEntry: @escaping (_ result: EntryResponse?, _ error: Error?) -> Void) {
            
            let parameters = [
                "a": Constants.getEntries,
                "session": "XHGpQZg9J0aG1fhtFy"
                ] as [String : Any]
            
            taskForPOSTMethod(requestURL: requestUrl, parameters: parameters) { (result: EntryResponse?, error: Error?) in
                if let error = error {
                    completionHandlerForAddEntry(nil, error)
                } else {
                    completionHandlerForAddEntry(result, nil)
                }
            }
        }
    
    // Generic POST запрос для остальных запросов
    func taskForPOSTMethod<T: Decodable>(requestURL: String, parameters: [String: Any], completionHandler: @escaping (_ result: T?, _ error: Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: requestURL)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        
        let postData = (parameters.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }) as Array).joined(separator: "&").data(using: .utf8)
        
        
        request.httpMethod = "POST"
        request.setValue("hnjL25I-dF-o5GcsPb", forHTTPHeaderField: "token")
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print("error with response status: \(String(describing: error))")
                completionHandler(nil, error)
                return
            } else {
                print("Yeah! Hand response")
                do {
                    guard let data = data else { return }
                    print(data)
                    
                    let objects = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(objects, nil)
                } catch let err {
                    print("Failed to decode from JSON:", err)
                    completionHandler(nil, err)
                    return
                }
            }
        })
        dataTask.resume()
    }
    
}
