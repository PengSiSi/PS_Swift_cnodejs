//
//  SQLiteError.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/26.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import Foundation

public enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}
