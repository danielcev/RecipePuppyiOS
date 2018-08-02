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
        
        Alamofire.request(Router.recipes(q: search))
            .responseJSON { response in
                
                switch response.result{
                    
                case .success:
                    let jsonResponse = JSON(response.data!)
                    
                    let response = RecipesResponse(json: jsonResponse)
                    
                    responseResult(response, false)
                    
                case .failure:
                    
                    responseResult(nil, true)
                    break
                }
                
                
                
        }
        
    }
}


