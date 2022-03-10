//
//  ServicesMockData.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

enum ServicesMockData {
    case listOfObjects

    var filePath: String? {
        switch self {
        case .listOfObjects:
            return Bundle.main.path(forResource: "ListOfObjectsMockData", ofType: "json")
        }
    }

    var url: URL? {
        switch self {
        case .listOfObjects:
            guard let path = filePath else { return nil }
            return URL(fileURLWithPath: path)
        }
    }

    var urlRequest: URLRequest? {
        switch self {
        case .listOfObjects:
            guard let url = url else { return nil }
            return generateUrlRequest(for: url)
        }
    }

    private func generateUrlRequest(for url: URL?) -> URLRequest? {
        guard let url = url else { return nil }
        return URLRequest(url: url,
                          cachePolicy: API.UrlRequests.Components.cachePolicy,
                          timeoutInterval: API.UrlRequests.Components.timeout)
    }
}
