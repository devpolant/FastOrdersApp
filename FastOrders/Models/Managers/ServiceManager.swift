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
typealias PlacesCompletionHandler = (_ success: Bool, _ message: String?, _ merchants: [Merchant]?) -> Void

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
    
    
    //MARK: - Places
    
    func loadPlaces(at location: Location, in radius: Double, completion: @escaping PlacesCompletionHandler) {
        
        Alamofire
            .request(PlacesRouter.inRadius(location: location, radius: radius, token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                
                var merchants = [Merchant]()
                
                for jsonObject in response["merchants"] as! [[String: Any]] {
                    let merchant = Merchant(from: jsonObject)
                    merchants.append(merchant)
                }
                completion(success, nil, merchants)
        }
    }
    
}


//MARK: - Auth Routing
enum AuthRouter: URLRequestConvertible {
    
    private static let baseURLString = "\(Constants.baseApiServicePath)/customer/auth"
    
    case loginUser(login: String, password: String)
    case registerUser(name: String, login: String, password: String)
    
    
    private var method: HTTPMethod {
        switch self {
        case .loginUser:
            return .post
        case .registerUser:
            return .post
        }
    }
    
    private var path: String {
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

//MARK: - Places Routing
enum PlacesRouter: URLRequestConvertible {
    
    private static let baseURLString = "\(Constants.baseApiServicePath)/customer/places"
    
    case all(token: String)
    case inRadius(location: Location, radius: Double, token: String)
    case info(merchantId: String, token: String)
    case menuCategories(merchantId: String, token: String)
    
    
    private var method: HTTPMethod {
        switch self {
        case .all:      fallthrough
        case .inRadius: fallthrough
        case .info:     fallthrough
        case .menuCategories:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .all:
            return "/all"
        case .inRadius:
            return "/radius"
        case let .info(merchantId, _):
            return "/info/\(merchantId)"
        case let .menuCategories(merchantId, _):
            return "/menu/\(merchantId)"
        }
    }
    
    private var token: String {
        switch self {
        case let .all(token):
            return token
        case let .inRadius(_, _, token):
            return token
        case let .info(_, token):
            return token
        case let .menuCategories(_, token):
            return token
        }
    }
    
    
    //MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try PlacesRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        switch self {
        case .all:
            break
        case let .inRadius(location, radius, _):
            let params = ["radius": radius,
                          "latitude": location.latitude,
                          "longitude": location.longitude]
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            
        case let .info(merchantId, _):
            let params = ["merchant_id": merchantId]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
            
        case let .menuCategories(merchantId, _):
            let params = ["merchant_id": merchantId]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}

