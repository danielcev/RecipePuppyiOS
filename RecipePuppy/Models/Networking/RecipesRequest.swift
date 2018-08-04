//
//  RecipesRequest.swift
//  RecipePuppy
//
//  Created by Daniel Plata on 2/8/18.
//  Copyright © 2018 Daniel Plata. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension RecipesResponse{
    
    static func getRecipesRequest(search: String, responseResult: @escaping (_ response: RecipesResponse?, _ error: Bool) -> ()){
        
        BaseAlamofire.makeRequest(request: Router.recipes(q: search)) { (jsonResult, success) in
            
            if success {
                let response = RecipesResponse(json: jsonResult!)
                responseResult(response, false)
            }else{
                responseResult(nil, true)
            }
            
        }
        
    }
}


