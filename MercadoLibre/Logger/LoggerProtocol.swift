//
//  LoggerProtocol.swift
//  MercadoLibre
//
//  Created by Pedro Ramos on 2/10/20.
//

import Foundation

enum LoggerEvent: String {
    case error = "‼️" // error
    case info = "💬" // debug
    case warning = "⚠️" // warning
}

protocol LoggerProtocol {
    // Log error message
    static func error(_ object: Any, filename: String, functionName: String)
    
    // Log debug message
    static func info(_ object: Any, filename: String, functionName: String)
    
    // Log warning message
    static func warning(_ object: Any, filename: String, functionName: String)
}

extension LoggerProtocol {
    static func print(_ info: String, with object: Any) {
        if Environment.logEnabled {
            Swift.print(info, object)
        }
    }
    
    static func sourceFileName(filePath: String) -> String {
        return FileManager.default.displayName(atPath: filePath)
    }
}
