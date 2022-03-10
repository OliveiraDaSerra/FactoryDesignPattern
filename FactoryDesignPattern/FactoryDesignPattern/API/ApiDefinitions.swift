//
//  ApiDefinitions.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

/// Services definitions
struct API {
    static let baseURL = "https://622688372dfa52401807a511.mockapi.io/api"

    struct Repositories {
        static let listOfStrings = "\(baseURL)/v1/listOfStrings"
    }

    struct UrlRequests {
        struct Components {
            static let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
            static let timeout = 60.0
        }

        static let headerParameters = ["Content-Type": "Application/JSON"]

        static func composeUrlRequest(for urlPath: String?,
                                      httpMethod: HttpMethod = .get,
                                      headerParams: [String: String]? = nil,
                                      bodyParams: [String: Any]? = nil) -> URLRequest? {
            guard let urlPath = urlPath, let url = URL(string: urlPath) else { return nil }
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: API.UrlRequests.Components.cachePolicy,
                                        timeoutInterval: API.UrlRequests.Components.timeout)
            urlRequest.httpMethod = httpMethod.value

            if let headerParams = headerParams {
                for (key, value) in headerParams { urlRequest.setValue(value, forHTTPHeaderField: key) }
            }

            if let bodyParams = bodyParams,
                let httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: []) {
                urlRequest.httpBody = httpBody
            }

            return urlRequest
        }

        static func composeMockUrlRequest(for mockData: ServicesMockData) -> URLRequest? {
            return mockData.urlRequest
        }
    }
}

