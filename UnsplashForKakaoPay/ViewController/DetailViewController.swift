//
//  DetailViewController.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func bindView(viewModel: PhotoViewModel?, currentIndex: Int)
}

class DetailViewController: UIViewController {
    
    private var viewModel: PhotoViewModel?
    private var currentIndex = 0
    private var isReachingEnd = false
    weak var delegate: DetailViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상세"
        self.setupCollectionView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        delegate?.bindView(viewModel: self.viewModel, currentIndex: self.currentIndex)
        super.viewDidDisappear(animated)
    }
    
    public func bindView(viewModel: PhotoViewModel?, currentIndex: Int) {
        self.viewModel = viewModel
        self.currentIndex = currentIndex
        DispatchQueue.main.async() { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "CustomCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.photos?.count ?? 0
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            return UICollectionViewCell()
        }
        
        if let photo = viewModel.photos?[indexPath.row] {
            cell.configureCell(imgUrl: photo.urls?.thumb)
        }
        
        return cell
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        if isReachingEnd {
            
            if let viewModel = self.viewModel {
                if viewModel.toatalPage > viewModel.currentPage || viewModel.toatalPage == 0 {
                    let currentPage = viewModel.currentPage
                    Network.sharedAPI.getPhotos(page: currentPage, query: self.viewModel?.query ?? "") { [weak self] (photos, totalPage) in
                        self?.viewModel?.currentPage += 1
                        self?.viewModel?.appendPhotos(photos: photos)
                        DispatchQueue.main.async() {
                            self?.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            self.currentIndex = indexPath?.row ?? 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let isReachingEnd = scrollView.contentOffset.x >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        self.isReachingEnd = isReachingEnd
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let viewModel = self.viewModel else {
            return CGSize.zero
        }
        
        if let item = viewModel.photos?[indexPath.row] {
            let width = collectionView.bounds.width
            let height = CGFloat(item.height ?? 0) * width / CGFloat(item.width ?? 0)
            return CGSize(width: width, height: height)
        } else {
            return CGSize.zero
        }
    }
}
