//
//  DailyNewsService.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 2/3/2567 BE.
//

import Foundation

protocol NewsService {
    func requestNews(url: String, completion: @escaping (Result<NewsModel, ErrorType>) -> Void)
    func requestSearchNews(url: String, completion: @escaping (Result<NewsModel, ErrorType>) -> Void)
}

class DailyNewsService: NewsService {
    
    func requestNews(url: String, completion: @escaping (Result<NewsModel, ErrorType>) -> Void) {
        APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    let responseNewsDisplay = try JSONDecoder().decode(NewsModel.self, from: data)
                    print("Response NewsDisplay : \(responseNewsDisplay)")
                    completion(.success(responseNewsDisplay))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(.failedToDecode))
                }
            case .failure( _ ):
                completion(.failure(.failedRequestSomething))
            }
        }
    }
    
    func requestSearchNews(url: String, completion: @escaping (Result<NewsModel, ErrorType>) -> Void) {
        APIManager.shared.request(endpoint: url, method: .get, headers: nil, body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    let responseSearchNewsDisplay = try JSONDecoder().decode(NewsModel.self, from: data)
                    print("Response SearchNewsDisplay : \(responseSearchNewsDisplay)")
                    completion(.success(responseSearchNewsDisplay))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(.failedToDecode))
                }
            case .failure( _ ):
                completion(.failure(.failedRequestSomething))
            }
        }
    }
}
