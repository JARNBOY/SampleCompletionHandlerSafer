//
//  ViewController.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 1/3/2567 BE.
//

import UIKit

protocol ViewDisplayLogic: AnyObject 
{
    func displayImagesPicsum(viewModel: View.Something.ViewModel)
    func displaySetStartText(viewModel: View.DisplayModel)
}

class ViewController: UIViewController, ViewDisplayLogic 
{
    @IBOutlet weak var imagesPicsumCollectionView: UICollectionView!
    @IBOutlet weak var startLabel: UILabel!
    
    var interactor: ViewBusinessLogic?
    var router: (NSObjectProtocol & ViewRoutingLogic & ViewDataPassing)?
    
    private var imageURLs: [String] = []
    
    let fileImageItemReuseableIdentifier = "ImageItemCollectionViewCell"
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ViewInteractor()
        let presenter = ViewPresenter()
        let router = ViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialView()
        setupCollectionView()
    }
    // MARK: View
    private func setupCollectionView() {
        imagesPicsumCollectionView.delegate = self
        imagesPicsumCollectionView.dataSource = self
        imagesPicsumCollectionView.register(
            UINib(nibName: fileImageItemReuseableIdentifier, bundle: nil),
            forCellWithReuseIdentifier: fileImageItemReuseableIdentifier
        )
    }
    
    // MARK: Button Action
    @IBAction func didTapStartGetImage(_ sender: UIButton) {
        self.interactor?.setStartText()
    }
    
    // MARK: Functional Screen Logic
    
    func initialView()
    {
        let request = View.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func getImagesPicsum() {
//        interactor?.getImagesPicsum()
    }
    
    // MARK: ViewDisplayLogic
    
    func displayImagesPicsum(viewModel: View.Something.ViewModel)
    {
        // Load a batch of images starting from the given index
        self.imageURLs += viewModel.urls
        imagesCollectionView.reloadData()
    }
    
    
    func displaySetStartText(viewModel: View.DisplayModel)
    {
        self.startLabel.isHidden = viewModel.isHide ?? false
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fileImageItemReuseableIdentifier, for: indexPath as IndexPath) as! ImageItemCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width
        let height = CGFloat(300)
        return CGSize(width: width, height: height)
    }
}
