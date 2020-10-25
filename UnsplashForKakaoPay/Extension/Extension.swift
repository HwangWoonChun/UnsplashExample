//
//  Extension.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import UIKit

fileprivate var imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func downloadImage(from url: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        
        contentMode = mode
        //cached Image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            DispatchQueue.main.async() { [weak self] in
                self?.image = cachedImage
            }
        } else {
            //downloadImage
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    }
}
