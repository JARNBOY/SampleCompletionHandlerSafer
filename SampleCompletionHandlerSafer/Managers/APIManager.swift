//
//  APIManager.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 2/3/2567 BE.
//

import Foundation

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

class APIManager {
    static let shared = APIManager()
    
    func request(endpoint: String, method: HTTPMethod , headers: [String: String]?, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(ErrorType.failedInvalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        print("Request : \(request)")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            print("Data : \(String(describing: data))")
            print("Response : \(String(describing: response))")
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ErrorType.failedToResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(ErrorType.failedNilData))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                completion(.success(data))
            } else {
                completion(.failure(ErrorType.failedRequest(httpResponse: httpResponse)))
            }
        }
        task.resume()
    }
}


enum LoadStatus: Equatable {
    case ready (nextPage: Int)
    case loading
    case parseError
    case done
}

enum ErrorType: LocalizedError, Equatable {
    case custom(error: Error)
    case failedToResponse
    case failedToDecode
    case failedInvalidURL
    case failedNilData
    case failedUnknown
    case failedLimitRequest
    case failedRequest(httpResponse: HTTPURLResponse)
    case failedRequestSomething
    
    var errorDescription: String? {
        switch self {
            
        case .custom(error: let error):
            return error.localizedDescription
        case .failedToDecode:
            return "Failed to decode response"
        case .failedInvalidURL:
            return "Failed to Invalid URL"
        case .failedToResponse:
            return "Failed to response"
        case .failedRequestSomething:
            return "Failed to request API request failed"
        case .failedRequest(httpResponse: let httpResponse):
            return "Failed to request API request failed with status code \(httpResponse.statusCode) : \(httpResponse.description)"
        case .failedNilData:
            return "Response is nil data"
        case .failedUnknown:
            return "Failed Unknown"
        case .failedLimitRequest:
            return "Failed Limited Request"
        }
    }
    
    static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
        return lhs.errorDescription == rhs.errorDescription
    }
}

enum StatusType: String {
    case ok = "ok"
    case error = "error"
}
