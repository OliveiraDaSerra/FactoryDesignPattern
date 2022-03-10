//
//  Requests.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import Foundation

// MARK: - Services

struct Services {

    static private func execute(urlRequest: URLRequest,
                                completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let data = data else { completionHandler(.failure(.badURL)) ; return }

            guard let httpResponse = response as? HTTPURLResponse
            else { completionHandler(.success(data)) ; return }

            guard httpResponse.statusCode == 200 else { completionHandler(.failure(.errorFetchingData)) ; return }
            completionHandler(.success(data))
        }
        task.resume()
    }

    static private func decode<T: Decodable>(_ type: T.Type,
                                             data: Data,
                                             completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            completionHandler(.success(result))
        } catch {
            print(">>> Error: \(error)")
            completionHandler(.failure(.errorDecoding))
        }
    }

    static func fetchData<T: Decodable>(_ type: T.Type,
                                        urlRequest: URLRequest?,
                                        completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = urlRequest else { completionHandler(.failure(.badURL)) ; return }
        Services.execute(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                decode(T.self, data: data, completionHandler: completionHandler)
            case .failure(let error):
                print(">>> Error: \(error)")
                completionHandler(.failure(.errorFetchingData))
            }
        }
    }

    private static func reportHttpError(from errorCode: Int) -> Error {
        switch errorCode {
        case 404:
            return NetworkError.urlNotFound
        case 500:
            return NetworkError.badURL
        default:
            return NetworkError.unknown
        }
    }
}
