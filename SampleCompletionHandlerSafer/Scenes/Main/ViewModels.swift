//
//  ViewModels.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 1/3/2567 BE.
//  Copyright (c) 2567 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum View
{
    // MARK: Use cases
    enum FetchImageURL
    {
        struct Request { }
        struct Response {
            let startIndex: Int
            let endIndex: Int
            let urls: [String]
        }
        struct ViewModel {
            let startIndex: Int
            let endIndex: Int
            let urls: [String]
        }
    }
    
    enum NewsFeed {
        struct Request { }
        struct Response {
            let news: NewsModel?
        }
        struct ViewModel {
            let articles: [Article]?
        }
    }
    
    struct DisplayModel {
        var isHide: Bool?
    }
}
