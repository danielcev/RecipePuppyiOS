//
//  BaseRequest.swift
//  RecipePuppy
//
//  Created by Daniel Plata on 4/8/18.
//  Copyright © 2018 Daniel Plata. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class BaseAlamofire{
    
    static func makeRequest(request: URLRequestConvertible, result: @escaping (_ json: JSON?, _ success: Bool) -> ()){
        
        Alamofire.request(request)
            .responseJSON { response in
                
                switch response.result{
                    
                case .success:
                    
                    let jsonResponse = JSON(response.data!)
                    
                    result(jsonResponse, true)
                    
                case .failure:
                    result(nil, false)
                    break
                }
                
        }
    }
}
