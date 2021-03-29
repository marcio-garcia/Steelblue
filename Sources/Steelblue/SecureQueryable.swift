//
//  File.swift
//  
//
//  Created by Marcio Garcia on 19/03/21.
//

import Foundation

public protocol SecureQueryable {
    var query: [String: Any] { get }
}

public struct GenericPasswordQueryable {
    let service: String
    let accessGroup: String?

    public init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

extension GenericPasswordQueryable: SecureQueryable {
    public var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        // Access group if target environment is not simulator
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[String(kSecAttrAccessGroup)] = accessGroup
        }
        #endif
        return query
    }
}

public struct InternetPasswordQueryable {
    let server: String
    let port: Int
    let path: String
    let securityDomain: String
    let internetProtocol: InternetProtocol
    let internetAuthenticationType: InternetAuthenticationType

    public init(server: String, port: Int, path: String, securityDomain: String, internetProtocol: InternetProtocol, internetAuthenticationType: InternetAuthenticationType) {
        self.server = server
        self.port = port
        self.path = path
        self.securityDomain = securityDomain
        self.internetProtocol = internetProtocol
        self.internetAuthenticationType = internetAuthenticationType
    }
}

extension InternetPasswordQueryable: SecureQueryable {
    public var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassInternetPassword
        query[String(kSecAttrPort)] = port
        query[String(kSecAttrServer)] = server
        query[String(kSecAttrSecurityDomain)] = securityDomain
        query[String(kSecAttrPath)] = path
        query[String(kSecAttrProtocol)] = internetProtocol.rawValue
        query[String(kSecAttrAuthenticationType)] = internetAuthenticationType.rawValue
        return query
    }
}

