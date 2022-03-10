//
//  ApiRequestsFactory.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

struct ListObject: Codable {
    var id: Int?
    var value: String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

class ApiRequestsFactory {
    static let shared = ApiRequestsFactory()

    func getList(for type: RequestTypeEnum = .realData,
                 completionHandler: @escaping (Result<[ListObject], NetworkError>) -> Void) {
        guard var urlRequest = API.UrlRequests.composeUrlRequest(for: API.Repositories.listOfStrings, httpMethod: .get, headerParams: API.UrlRequests.headerParameters)
        else { completionHandler(.failure(.badURL)) ; return }

        if type == .mockData,
           let mockDataUrlRequest = API.UrlRequests.composeMockUrlRequest(for: .listOfObjects) {
            urlRequest = mockDataUrlRequest
        }

        execute(responseType: [ListObject].self,
                urlRequest: urlRequest,
                completionHandler: completionHandler)
    }

    private func execute<T: Decodable>(responseType: T.Type,
                                              urlRequest: URLRequest,
                                              completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        Services.fetchData(responseType,
                           urlRequest: urlRequest,
                           completionHandler: completionHandler)
    }

    private func createRequest(for urlPath: String,
                                      headerParams: [String: String]) -> URLRequest? {
        guard let urlRequest = API.UrlRequests.composeUrlRequest(for: urlPath, headerParams: headerParams) else { return nil }
        return urlRequest
    }
}
