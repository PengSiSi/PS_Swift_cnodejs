//
//  NSDate+Extension.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/4.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation

extension NSDate {
    
    /// 取得当前日期
    ///
    /// - Returns: 以字符串形式返回当前日期
    class func getCurrentDate() -> String{
        
        return "\(NSDate().timeIntervalSince1970)"//interval
    }
    
    /// 格式化时间
    ///
    /// - Parameters:
    ///   - formatString: 格式符
    ///   - timezoneAbbr: The abbreviation for the time zone.
    ///   - localeIdentifier: the specified identifier.
    /// - Returns: 格式化的字符串
    public func toDateString(formatString: String,timezoneAbbr: String,localeIdentifier:String) -> String{
        return toDasteString(formatString: formatString, timezone: TimeZone(abbreviation: timezoneAbbr)!, localeIdentifier: localeIdentifier)
    }
    
    
    /// 格式化时间
    ///
    /// - Parameters:
    ///   - formatString: 格式符
    ///   - timezone: 时区
    ///   - localeIdentifier: the specified identifier.
    /// - Returns: 格式化的字符串
    public func toDasteString(formatString: String,timezone: TimeZone,localeIdentifier:String) -> String{
        let dataFormat = DateFormatter()
        dataFormat.locale = Locale(identifier: localeIdentifier)
        dataFormat.timeZone = timezone
        dataFormat.dateFormat = formatString
        return dataFormat.string(from: self as Date)
    }
    
    // 处理日期的格式
    public class func changeDateTime(publish_time: Int) -> String {
        
        // 秒转换为时间
        let publishTime = Date(timeIntervalSince1970: TimeInterval(publish_time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let delta = Date().timeIntervalSince(publishTime)
        if delta <= 0 {
            return " 刚刚"
        } else if delta < 60 {
            return "\(Int(delta))秒前"
        } else if delta < 3600 {
            return "\(Int(delta) / 60)分钟前"
        } else {
            let calendar = Calendar.current
            // 现在
            let comp1 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            // 发布时间
            let comp2 = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: publishTime)
            if comp1.year == comp2.year {
                if comp1.day == comp2.day {
                    return "\(comp1.hour! - comp2.hour!)小时前"
                } else {
                    return "\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
                }
            } else {
                return "\(comp2.year)-\(comp2.month)-\(comp2.day) \(comp2.hour):\(comp2.minute)"
            }
        }
    }
}
