//
//  API.swift
//  ThaShop
//
//  Created by Ty rainey on 9/27/18.
//  Copyright © 2018 Ty rainey. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case failure
}

typealias JSON = [String : String]
typealias APICompletionHandler = (Result<[JSON]>) -> Void

class API: NSObject {
    static let shared = API()
    
    func loadJSONFromRequest(completion: @escaping APICompletionHandler) {
        do {
            if let file = Bundle.main.url(forResource: "team", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let json = object as? [JSON] {
                    completion(.success(json))
                } else {
                    completion(.failure)
                }
            }
        } catch {
            print("catch error")
            completion(.failure)
        }
    }
}
