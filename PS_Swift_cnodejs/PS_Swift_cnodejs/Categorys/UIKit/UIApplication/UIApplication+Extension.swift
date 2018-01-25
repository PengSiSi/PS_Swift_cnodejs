//
//  UIApplication+Extension.swift
//  SwiftTools
//
//  Created by 思 彭 on 2017/5/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    // application文件大小
    public var applicationFileSize: String {
        func sizeOfFolderPath(_ folderPath: String) -> Int64 {
            let contents: [String]?
            do {
                contents = try FileManager.default.contentsOfDirectory(atPath: folderPath)
            } catch _ {
                contents = nil
            }
            var folderSize: Int64 = 0
            
            if let tempContents = contents{
                for file in tempContents {
                    let dict = try?  FileManager.default.attributesOfItem(atPath: (folderPath as NSString).appendingPathComponent(file))
                    if dict != nil {
                        folderSize += (dict![FileAttributeKey.size] as? Int64) ?? 0
                    }
                }
            }
            return folderSize
        }
        
        let docSize = sizeOfFolderPath(self.m_documentPath)
        let libSzie = sizeOfFolderPath(self.m_libraryPath)
        let cacheSize = sizeOfFolderPath(self.m_cachePath)
        let total = docSize + libSzie + cacheSize + cacheSize
        let folderSizeStr = ByteCountFormatter.string(fromByteCount: total, countStyle: .file)
        
        return folderSizeStr
    }
    
    //Document路径
    public var m_documentPath: String {
        let dstPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return dstPath
    }
    
    // library路径
    public var m_libraryPath: String {
        let dstPath =  NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        return dstPath
    }
    
    // cache路径
    public var m_cachePath: String {
        let dstPath =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
        return dstPath
    }
    
    public class func appBundleName() -> String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
    
    public class func appDisplayName() -> String{
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    /// App版本
    public class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /// App构建版本
    public class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }

    public class var iconFilePath: String {
        let iconFilename = Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile")
        let iconBasename = (iconFilename as! NSString).deletingPathExtension
        let iconExtension = (iconFilename as! NSString).pathExtension
        return Bundle.main.path(forResource: iconBasename, ofType: iconExtension)!
    }
    
    public class func iconImage() -> UIImage? {
        guard let image = UIImage(contentsOfFile:self.iconFilePath) else {
            return nil
        }
        return image
    }
    
    public class func versionDescription() -> String {
        let version = appVersion()
        #if DEBUG
            return "Debug - \(version)"
        #else
            return "Release - \(version)"
        #endif
    }
    
//    public class func sendEmail(toAddress address: String) {
//        guard address.count > 0 else { return }
//        UIApplication.shared.openURL(URL(string: "mailto://\(address)")!)
//    }
}

// MARK: - UserDefaults
extension UserDefaults {
    
    public subscript(key: String) -> Any? {
        get { return value(forKey: key) as Any }
        set {
            switch newValue {
            case let value as Int: set(value, forKey: key)
            case let value as Double: set(value, forKey: key)
            case let value as Bool: set(value, forKey: key)
            case let value as String: set(value, forKey: key)
            case nil: removeObject(forKey: key)
            default: assertionFailure("Invalid value type.")
            synchronize()
            }
        }
    }
    
    public func hasKey(_ key: String) -> Bool {
        return nil != object(forKey: key)
    }
    
    static func save(at value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func get(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

