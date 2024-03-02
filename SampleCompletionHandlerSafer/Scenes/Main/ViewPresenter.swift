//
//  ViewPresenter.swift
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

protocol ViewPresentationLogic
{
    func presentImagesPicsum(response: View.Something.Response)
    func presentSetStartText()
}

class ViewPresenter: ViewPresentationLogic
{
    weak var viewController: ViewDisplayLogic?
    
    // MARK: Do something
    
    func presentImagesPicsum(response: View.Something.Response)
    {
        let viewModel = View.Something.ViewModel()
        viewController?.displayImagesPicsum(viewModel: viewModel)
    }
    
    func presentSetStartText()
    {
        let viewModel = View.DisplayModel(isHide: true)
        viewController?.displaySetStartText(viewModel: viewModel)
    }
}
