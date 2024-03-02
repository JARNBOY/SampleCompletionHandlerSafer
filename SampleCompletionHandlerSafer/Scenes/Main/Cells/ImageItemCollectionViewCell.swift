//
//  ImageItemCollectionViewCell.swift
//  SampleCompletionHandlerSafer
//
//  Created by Papon Supamongkonchai on 1/3/2567 BE.
//

import UIKit
import SDWebImage

class ImageItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mContent: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleImageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupConfigureCell(article: Article) {
        itemImageView.sd_setImage(with: URL(string: article.urlToImage ?? ""), placeholderImage: UIImage(systemName: "doc.circle"))
        titleImageLabel.text = article.title
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: 300)
    }
}
