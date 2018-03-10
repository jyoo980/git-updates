//
//  APILogger.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-09.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class APILogger {
    
    static let shared = APILogger()
    var logs : [String]
    var totalCalls : Int
    
    private init() {
        logs = [String]()
        totalCalls = 0
    }
    
    func log(event: String) {
        logs.append(event)
        totalCalls += 1
        print("API Call Made, Call Number: " + String(totalCalls))
    }
    
    func printLog() {
        for log in logs {
            print(log)
        }
    }

}
