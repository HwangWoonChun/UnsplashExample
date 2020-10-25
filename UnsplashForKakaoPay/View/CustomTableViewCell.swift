//
//  CustomCell.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import UIKit

class CustomTableViewCell : UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    
    public func configureCell(imgUrl: String?) {
        if let url = imgUrl {
            self.imgView.downloadImage(from: url)
        }
    }
}
