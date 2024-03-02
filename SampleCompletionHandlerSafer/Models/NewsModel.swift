//
//  NewsModel.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 2/3/2567 BE.
//

import Foundation

struct NewsModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article] = []
}

struct Article: Codable, Equatable {
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
}
