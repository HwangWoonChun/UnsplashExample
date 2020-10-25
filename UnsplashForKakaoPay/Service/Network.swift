//
//  Network.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import Foundation

struct UnsplashInfo {
    static let client_id = "gH4_brAa1qp4wx6vNrR6ufzhbItE2Io9hTVNFcAumw8"
    static let secrete_key = "LWQC6KlDArqQaJvH507lGQ3W6C-gIDLCPs8O7njXVWI"
    static let response_type = "code"
    static let scope = "public"
    static let redirect_uri = "UnsplashForKakaoPay://unsplash"
}

struct CommonURL {
    //common
    static let commonDomain: String = "https://unsplash.com"
    static let commonAPIDomain: String = "https://api.unsplash.com"
    //API URL
    static let photos: String = "/photos"
    //API URL
    static let search: String = "/search/photos/?client_id=\(UnsplashInfo.client_id)"
    //Auth URL
    static let authUrl: String = "https://unsplash.com/oauth/authorize?client_id=\(UnsplashInfo.client_id)&redirect_uri=\(UnsplashInfo.redirect_uri)&response_type=\(UnsplashInfo.response_type)&scope=\(UnsplashInfo.scope)"
    //Auth Token
    static let authTokenUrl: String = "/oauth/token"
}

class Network {
    //Base
    static let sharedAPI = Network()
    
    //Auth
    func getAuthToken(code: String, completionHandler: @escaping () -> Void) {

        let requestString = "\(CommonURL.commonDomain)\(CommonURL.authTokenUrl)?client_id=\(UnsplashInfo.client_id)" + "&client_secret=\(UnsplashInfo.secrete_key)" + "&redirect_uri=\(UnsplashInfo.redirect_uri)" + "&code=\(code)" + "&grant_type=authorization_code"
        guard let serviceUrl = URL(string: requestString) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"

        let session = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                completionHandler()
            }
            do {
                if let data = data {
                    let decoded = try JSONDecoder().decode(EccessToken.self, from: data)
                    UserDefaults.standard.set(decoded.access_token, forKey: "access_token")
                    completionHandler()
                } else {
                    completionHandler()
                }
            } catch {
                print(error)
                completionHandler()
            }
        }
        session.resume()
    }
    
    //API - search + photos
    func getPhotos(page: Int, query: String = "", completionHandler: @escaping ([Unsplash]?, Int) -> Void) {
        
        let photoURL = "\(CommonURL.commonAPIDomain)\(CommonURL.photos)"
        let searchURL = "\(CommonURL.commonAPIDomain)\(CommonURL.search)"

        var url = photoURL
        var requestString = url + "?page=\(page)"
        
        if query.count > 0 {
            url = searchURL
            requestString = url + "&query=\(query)"
        }
        
        guard let serviceUrl = URL(string: requestString) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"

        guard let access_token = UserDefaults.standard.string(forKey: "access_token") else {
            print("accessToken need")
            return
        }
        
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")

        let session = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                completionHandler(nil, 0)
            }
            do {
                if let data = data {
                    if query.count > 0 {
                        let decoded = try JSONDecoder().decode(UnsplashSearch.self, from: data)
                        completionHandler(decoded.results, decoded.total_pages ?? 0)
                    } else {
                        
                        let decoded = try JSONDecoder().decode([Unsplash].self, from: data)
                        completionHandler(decoded, 0)
                    }
                } else {
                    completionHandler(nil, 0)
                }
            } catch {
                print(error)
                completionHandler(nil, 0)
            }
        }
        session.resume()
    }
}
