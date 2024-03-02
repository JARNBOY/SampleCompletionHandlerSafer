//
//  ViewInteractor.swift
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

protocol ViewBusinessLogic
{
    func feedImagesPicsum()
    func setStartText()
    func feedNews()
}

protocol ViewDataStore
{
    //var name: String { get set }
}

class ViewInteractor: ViewBusinessLogic, ViewDataStore
{
    var presenter: ViewPresentationLogic?
    var worker: ViewWorker = ViewWorker(with: DailyNewsService())
    //var name: String = ""

    // MARK: Do something

    func feedImagesPicsum() {
        let startIndex = 0
        let endIndex = 12
        worker.generateListURL(startIndex: startIndex, endIndex: endIndex) { imageUrls in
            print(imageUrls)
            let response = View.FetchImageURL.Response(startIndex: startIndex, endIndex: endIndex, urls: imageUrls)
            presenter?.presentImagesPicsum(response: response)
        }
    }

    func feedNews() {
        worker.requestNews { [weak self] newsModel, errorType in
            DispatchQueue.main.async {
                guard
                    errorType == nil
                else {
                    //Display error each type
                    print(errorType?.errorDescription ?? "")
                    return
                }
                let response = View.NewsFeed.Response(news: newsModel)
                self?.presenter?.presentFeedNews(response: response)
            }
        }
    }

    func setStartText() {
        presenter?.presentSetStartText()
    }
}


