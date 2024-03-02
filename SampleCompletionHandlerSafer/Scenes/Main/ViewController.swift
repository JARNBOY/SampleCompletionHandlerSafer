//
//  ViewController.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 1/3/2567 BE.
//

import UIKit

protocol ViewDisplayLogic: AnyObject 
{
    func displayImagesPicsum(viewModel: View.FetchImageURL.ViewModel)
    func displaySetStartText(viewModel: View.DisplayModel)
    func displayFeedNews(viewModel: View.NewsFeed.ViewModel)
}

class ViewController: UIViewController, ViewDisplayLogic 
{
    @IBOutlet weak var imagesPicsumCollectionView: UICollectionView!
    @IBOutlet weak var startLabel: UILabel!
    
    var interactor: ViewBusinessLogic?
    var router: (NSObjectProtocol & ViewRoutingLogic & ViewDataPassing)?
    
    private var imageURLs: [String] = []
    private var articles: [Article] = []
    
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
        let request = View.NewsFeed.Request()
        interactor?.feedNews()
    }
    
    // MARK: Functional Screen Logic
    func getImagesPicsum() {
        interactor?.feedImagesPicsum()
    }
    
    // MARK: ViewDisplayLogic
    
    func displayImagesPicsum(viewModel: View.FetchImageURL.ViewModel)
    {
        // Load a batch of images starting from the given index
        self.imageURLs += viewModel.urls
        imagesPicsumCollectionView.reloadData()
    }
    
    func displayFeedNews(viewModel: View.NewsFeed.ViewModel) {
        self.interactor?.setStartText()
        self.articles = viewModel.articles ?? []
        imagesPicsumCollectionView.reloadData()
    }
    
    func displaySetStartText(viewModel: View.DisplayModel)
    {
        self.startLabel.isHidden = viewModel.isHide ?? false
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fileImageItemReuseableIdentifier, for: indexPath as IndexPath) as! ImageItemCollectionViewCell
        cell.setupConfigureCell(article: self.articles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = CGFloat(300)
        return CGSize(width: width, height: height)
    }
}
