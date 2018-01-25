//
//  SafeDispatch.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation

final public class SafeDispatch {
    
    private let mainQuenueKey = DispatchSpecificKey<Int>()
    private let mainQuenueValue = Int(1)
    
    private static let sharedSafeDispatch = SafeDispatch()
    
    private init() {
        DispatchQueue.main.setSpecific(key: mainQuenueKey, value: mainQuenueValue)
    }
    
    public class func async(onQueue queue: DispatchQueue = DispatchQueue.main, forWork block: @escaping () -> Void) {
        if queue === DispatchQueue.main {
            if DispatchQueue.getSpecific(key: sharedSafeDispatch.mainQuenueKey) == sharedSafeDispatch.mainQuenueValue {
                block()
            } else {
                DispatchQueue.main.async {
                    block()
                }
            }
        } else {
            queue.async {
                block()
            }
        }
    }
}
