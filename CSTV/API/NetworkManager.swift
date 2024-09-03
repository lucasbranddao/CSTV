//
//  NetworkManager.swift
//  CSTV
//
//  Created by Lucas Brandão on 03/09/24.
//

import Foundation
import Combine

final class NetworkService {

    static let shared = NetworkService()

    private init() {}

    func performRequest<T: Decodable>(with url: URL, responseType: T.Type) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(APIConstants.token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: responseType, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func performRequest<T: Decodable>(
        with url: URL,
        responseType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(APIConstants.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(responseType, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

