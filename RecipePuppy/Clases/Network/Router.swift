//
//  Router.swift
//  RecipePuppy
//
//  Created by Daniel Plata on 2/8/18.
//  Copyright © 2018 Daniel Plata. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible
{
    case recipes(q:String)

    struct recipesURL
    {
        static let baseURLString = "http://www.recipepuppy.com/api/"
    }

    var method: HTTPMethod
    {
        switch self
        {
            
        case .recipes:
            return .get

        }
    }
    
    /*
     QueryParams in URL
     */
    var queryParams: Parameters
    {
        var queryParams : Parameters
        
        switch self
        {
            
        case .recipes(let q):
            queryParams = Parameters(dictionaryLiteral:("q", q))
        default:
            queryParams = [:]
            break
        }
        return queryParams
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.recipesURL.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: queryParams)

        return urlRequest
    }
    
}
