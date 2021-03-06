//
//  Utility.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-26.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

func dataToDict(data: Data?) -> NSDictionary {
    return try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
}

func dataToArray(data: Data?) -> NSArray? {
    do{
        let array = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray
        return array
    } catch {
        return NSArray()
    }
}
