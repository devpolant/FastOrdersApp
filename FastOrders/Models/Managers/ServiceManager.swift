//
//  ServiceManager.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import Alamofire

typealias AuthCompletionHandler = (_ success: Bool, _ message: String) -> Void

class ServiceManager {
    
    static let shared = ServiceManager()
    
    private init() { }
    
    
    //MARK: - Token
    
    fileprivate var accessToken: String?
    
    
    //MARK: - Auth
    
    func sendLogin(login: String, password: String, completion: @escaping AuthCompletionHandler) {
        
        Alamofire
            .request(AuthRouter.loginUser(login: login, password: password))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong")
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as! String
                self.accessToken = response["access_token"] as? String
                
                completion(success, message)
        }
    }
    
    func sendRegister(name: String, login: String, password: String, completion: @escaping AuthCompletionHandler) {
        
        Alamofire
            .request(AuthRouter.registerUser(name: name, login: login, password: password))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong")
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as! String
                self.accessToken = response["access_token"] as? String
                
                completion(success, message)
        }
    }
    
}


//MARK: - Routing
enum AuthRouter: URLRequestConvertible {
    
    private static let baseURLString = "\(Constants.baseApiServicePath)/customer/auth"
    
    case loginUser(login: String, password: String)
    case registerUser(name: String, login: String, password: String)
    
    
    var method: HTTPMethod {
        switch self {
        case .loginUser:
            return .post
        case .registerUser:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "/login"
        case .registerUser:
            return "/register"
        }
    }
    
    
    //MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try AuthRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case let .loginUser(login, password):
            let params = ["login": login, "password": password]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            
        case let .registerUser(name, login, password):
            let params = ["name": name, "login": login, "password": password]
            urlRequest = try URLEncoding.default.encode(urlRequest, with:params)
        }
        return urlRequest
    }
}


//class AccessTokenAdapter: RequestAdapter {
//    
//    private let accessToken: String?
//    
//    init(accessToken: String?) {
//        self.accessToken = accessToken
//    }
//    
//    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        
//
//        var urlRequest = urlRequest
//
//        guard let token = accessToken else { return urlRequest }
//        
//        let needsToken = !urlRequest.url!.pathComponents.contains { pathComponent in
//            return pathComponent == "login" || pathComponent == "register"
//        }
//        
//        if needsToken {
//            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        }
//        
//        return urlRequest
//    }
//}

