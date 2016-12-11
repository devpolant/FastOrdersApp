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
typealias MenuCategoriesCompletionHandler = (_ success: Bool, _ message: String?, _ merchants: [MenuCategory]?) -> Void
typealias MenuItemsCompletionHandler = (_ success: Bool, _ message: String?, _ merchants: [MenuItem]?) -> Void
typealias OrdersCompletionHandler = (_ success: Bool, _ message: String?, _ orders: [Order]?) -> Void
typealias CreateOrderCompletionHandler = (_ success: Bool, _ message: String, _ order: Order?) -> Void

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
                
                debugPrint("Logged In: \(response)")
                
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
                
                debugPrint("Registered: \(response)")
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as! String
                self.accessToken = response["access_token"] as? String
                
                completion(success, message)
        }
    }
    
    func sendLogout(completion: @escaping AuthCompletionHandler) {
        
        Alamofire
            .request(AuthRouter.logout(token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong")
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as! String
                
                if success {
                    self.accessToken = nil
                }
                
                completion(success, message)
        }
    }
    
    
    //MARK: - Places
    
    func loadAllPlaces(completion: @escaping PlacesCompletionHandler) {
        
        Alamofire
            .request(PlacesRouter.all(token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as? String
                
                var merchants = [Merchant]()
                
                for jsonObject in response["merchants"] as! [[String: Any]] {
                    let merchant = Merchant(from: jsonObject)
                    merchants.append(merchant)
                }
                completion(success, message, merchants)
        }
    }
    
    func loadPlaces(at location: Location, in radius: Double, completion: @escaping PlacesCompletionHandler) {
        
        Alamofire
            .request(PlacesRouter.inRadius(location: location, radius: radius, token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as? String
                
                var merchants = [Merchant]()
                
                for jsonObject in response["merchants"] as! [[String: Any]] {
                    let merchant = Merchant(from: jsonObject)
                    merchants.append(merchant)
                }
                completion(success, message, merchants)
        }
    }
    
    
    func loadMenuCategories(for merchant: Merchant, completion: @escaping MenuCategoriesCompletionHandler) {
        
        Alamofire
            .request(PlacesRouter.menuCategories(merchantId: merchant.id, token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as? String
                
                var categories = [MenuCategory]()
                
                for jsonObject in response["menu_categories"] as! [[String: Any]] {
                    let category = MenuCategory(from: jsonObject)
                    categories.append(category)
                }
                completion(success, message, categories)
        }
    }
    
    func loadMenuItems(for category: MenuCategory, completion: @escaping MenuItemsCompletionHandler) {
        
        Alamofire
            .request(PlacesRouter.menuItems(categoryId: category.id, token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as? String
                
                var items = [MenuItem]()
                
                for jsonObject in response["menu_items"] as! [[String: Any]] {
                    let menuItem = MenuItem(from: jsonObject)
                    items.append(menuItem)
                }
                completion(success, message, items)
        }
    }
    
    
    //MARK: - Orders
    
    func loadOrders(completion: @escaping OrdersCompletionHandler) {
        
        Alamofire
            .request(OrderRouter.list(token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as? String
                
                var orders = [Order]()
                
                for jsonObject in response["orders"] as! Array<[String: Any]> {
                    let order = Order(from: jsonObject)
                    orders.append(order)
                }
                completion(success, message, orders)
        }
    }
    
    
    func createOrder(merchantId: String, with items: [CartItem], orderDate: Date, completion: @escaping CreateOrderCompletionHandler) {
        
        Alamofire
            .request(OrderRouter.create(merchantId: merchantId,
                                        items: items,
                                        orderDate: orderDate,
                                        token: self.accessToken!))
            .responseJSON { (dataResponse) in
                
                guard let response = dataResponse.result.value as? [String: Any] else {
                    completion(false, "Something went wrong", nil)
                    return
                }
                
                let success = !(response["error"] as! Bool)
                let message = response["message"] as! String
                let orderJson = response["order"] as! [String: Any]
                
                let order = Order(from: orderJson)
                
                completion(success, message, order)
        }
    }
    
}


//MARK: - Auth Routing
enum AuthRouter: URLRequestConvertible {
    
    private static let baseURLString = "\(Constants.baseApiServicePath)/customer/auth"
    
    case loginUser(login: String, password: String)
    case registerUser(name: String, login: String, password: String)
    case logout(token: String)
    
    private var method: HTTPMethod {
        switch self {
        case .loginUser: fallthrough
        case .registerUser: fallthrough
        case .logout:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .loginUser:
            return "/login"
        case .registerUser:
            return "/register"
        case .logout:
            return "/logout"
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
        case let .logout(token):
            urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
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
    case menuItems(categoryId: String, token: String)
    
    
    private var method: HTTPMethod {
        switch self {
        case .all:              fallthrough
        case .inRadius:         fallthrough
        case .info:             fallthrough
        case .menuCategories:   fallthrough
        case .menuItems:
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
        case let .menuItems(categoryId, _):
            return "/items/\(categoryId)"
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
        case let .menuItems(_, token):
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
    
        case let .menuItems(categoryId, _):
            let params = ["category_id": categoryId]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }
}


//MARK: - Orders Routing
enum OrderRouter: URLRequestConvertible {
    
    private static let baseURLString = "\(Constants.baseApiServicePath)/orders/customer"
    
    case list(token: String)
    case create(merchantId: String, items: [CartItem], orderDate: Date, token: String)
    
    private var method: HTTPMethod {
        switch self {
        case .list:     fallthrough
        case .create:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .list:
            return "/list"
        case .create:
            return "/create"
        }
    }
    
    private var token: String {
        switch self {
        case let .list(token):
            return token
        case let .create(_, _, _, token):
            return token
        }
    }
    
    
    //MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try OrderRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        switch self {
        case .list:
            break
        case let .create(merchantId, cartItems, orderDate, _):
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let availabilityDate = orderDate.timeIntervalSince1970
            
            var items = Array<[String: Any]>()
            for item in cartItems {
                items.append([
                    "item_id": item.menuItem.id,
                    "quantity": item.quantity
                    ])
            }
            
            let params = ["merchant_id": merchantId,
                          "availability_date": availabilityDate,
                          "items": items] as [String : Any]
            
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: params)
            break
        }
        
        return urlRequest
    }
}
