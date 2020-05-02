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
    
    func callAlgorithm() {
        AF.request("https://us-central1-tohacks-2020-276017.cloudfunctions.net/algorithm").response { (response) in
            print(response)
        }
    }
}
