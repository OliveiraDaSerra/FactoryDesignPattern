//
//  NetworkError.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

enum NetworkError: Error {
    case noError, badURL, badFormat, errorDecoding, errorFetchingData, urlNotFound, unknown
}
