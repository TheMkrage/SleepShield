//
//  BackendCaller.swift
//  SleepShield
//
//  Created by Matthew Krager on 5/2/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Alamofire

class BackendCaller: NSObject {
    static let shared = BackendCaller()
    private override init() { }
    
    func callAlgorithm(algorithmInput: AlgorithmInput, callback: @escaping (AlgorithmOutput)->Void) {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        AF.request("https://us-central1-tohacks-2020-276017.cloudfunctions.net/algorithm",
                   method: .post,
                   parameters: algorithmInput,
                   encoder: JSONParameterEncoder(encoder: encoder)
        ).response { (response) in
            print(response)
            debugPrint(response)
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let loginRequest = try decoder.decode(AlgorithmOutput.self, from: data)
                callback(loginRequest)
            } catch let error {
                print(error)
            }
        }
    }
}
