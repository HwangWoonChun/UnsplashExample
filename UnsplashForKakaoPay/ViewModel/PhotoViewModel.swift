//
//  PhotoViewModel.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import Foundation

class PhotoViewModel {

    var photos: [Unsplash]?
    var currentPage: Int = 1
    var query: String?
    var toatalPage: Int = 0

    init(photos: [Unsplash]?, currentPage: Int, query: String = "", totalPage: Int = 0) {
        self.photos = photos
        self.currentPage = currentPage
        self.query = query
        self.toatalPage = totalPage
    }
    
    public func appendPhotos(photos: [Unsplash]?) {
        if let photos = photos {
            self.photos?.append(contentsOf: photos)
        }
    }
}
