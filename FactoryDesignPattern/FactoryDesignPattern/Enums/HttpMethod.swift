//
//  HttpMethod.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

enum HttpMethod {
    case get, post

    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
