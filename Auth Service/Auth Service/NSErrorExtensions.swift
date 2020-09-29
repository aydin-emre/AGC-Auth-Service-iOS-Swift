//
//  NSErrorExtensions.swift
//  Auth Service
//
//  Created by Emre AYDIN on 9/29/20.
//

import Foundation

let NetworkClientErrorDomain = "NetworkClientErrorDomain"

enum ErrorCode: Int {
    case success                            = 200
    
    case notFound                           = 404
    
    case invalidParameters                  = -1000
    case invalidJSON                        = -1001
    case invalidData                        = -1002
    
    case noAuthenticatedUser                = -1003
    case unknownError                       = -1004
}

extension NSError {
    
    convenience init(withInt code: Int) {
        self.init(domain: NetworkClientErrorDomain,
                  code: code,
                  userInfo: nil)
    }
    
    convenience init(withCode code: ErrorCode) {
        self.init(domain: NetworkClientErrorDomain,
                  code: code.rawValue,
                  userInfo: nil)
    }
    
    convenience init(withCode code: Int?, andMessage message: String?) {
        var info: [AnyHashable: Any] = [:]
        var inlineCode: Int = ErrorCode.unknownError.rawValue
        
        if let code = code {
            inlineCode = code
        }
        
        if let message = message {
            info[NSLocalizedDescriptionKey] = message
        }
        
        self.init(domain: NetworkClientErrorDomain,
                  code: inlineCode,
                  userInfo: info as? [String : Any])
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
