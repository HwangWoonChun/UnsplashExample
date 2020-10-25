//
//  ViewController.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    private var viewModel: PhotoViewModel?
    private var isReachingEnd = false
    private var authSession: ASWebAuthenticationSession?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtFiled: UITextField!
    
    @IBAction func pushedSearchButton(sender: Any) {
        let startPage = 1
        Network.sharedAPI.getPhotos(page: startPage, query: self.txtFiled.text ?? "") { [weak self] (photos, totalPage) in
            if let photos = photos {
                DispatchQueue.main.async() {
                    self?.viewModel = PhotoViewModel(photos: photos, currentPage: startPage, query: self?.txtFiled.text ?? "", totalPage: totalPage)
                    self?.tableView.reloadData()
                    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색"
        self.setupTableView()
        self.getAuth()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func getAuth() {
        self.authSession = ASWebAuthenticationSession(
            url: URL(string: CommonURL.authUrl)!,
            callbackURLScheme: UnsplashInfo.redirect_uri,
            completionHandler: { (callbackUrl, error) in
                guard let callbackUrl = callbackUrl else { return }
                let split = callbackUrl.absoluteString.replacingOccurrences(of: "unsplashforkakaopay://unsplash?code=", with: "")
                Network.sharedAPI.getAuthToken(code: split) {
                    self.bindView()
                }
            })
        if #available(iOS 13.0, *) {
            self.authSession?.presentationContextProvider = self
        }
        
        authSession?.start()
    }
    
    private func bindView() {
        let startPage = 1
        Network.sharedAPI.getPhotos(page: startPage) { [weak self] (photos, totalPage) in
            if let photos = photos {
                DispatchQueue.main.async() { [weak self] in
                    self?.viewModel = PhotoViewModel(photos: photos, currentPage: startPage, query: self?.txtFiled.text ?? "")
                    self?.viewModel?.currentPage += 1
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewModel = self.viewModel else {
            return 0
        }
        return viewModel.photos?.count ?? 0
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        guard let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        
        if let photo = viewModel.photos?[indexPath.row] {
            cell.configureCell(imgUrl: photo.urls?.thumb)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let viewModel = self.viewModel else {
            return 0
        }
        
        if let item = viewModel.photos?[indexPath.row] {
            let width = tableView.frame.width
            let height = CGFloat(item.height ?? 0) * width / CGFloat(item.width ?? 0)
            return height
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = self.viewModel else {
            return
        }
        
        if let _ = viewModel.photos?[indexPath.row] {
            if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailVC.bindView(viewModel: self.viewModel, currentIndex: indexPath.row)
                detailVC.delegate = self
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if isReachingEnd {
            if let viewModel = self.viewModel {
                if viewModel.toatalPage > viewModel.currentPage || viewModel.toatalPage == 0 {
                    let currentPage = viewModel.currentPage
                    Network.sharedAPI.getPhotos(page: currentPage, query: self.txtFiled.text ?? "") { [weak self] (photos, totalPage) in
                        self?.viewModel?.currentPage += 1
                        self?.viewModel?.appendPhotos(photos: photos)
                        DispatchQueue.main.async() {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        self.isReachingEnd = isReachingEnd
    }
    
}

//MARK: DetailViewControllerDelegate
extension ViewController: DetailViewControllerDelegate {
    func bindView(viewModel: PhotoViewModel?, currentIndex: Int) {
        
        self.viewModel = viewModel
        DispatchQueue.main.async() { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.scrollToRow(at: IndexPath(row: currentIndex, section: 0), at: .middle, animated: false)
        }
    }
}

//MARK: ASWebAuthenticationPresentationContextProviding
extension ViewController: ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
