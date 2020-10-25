//
//  Model.swift
//  UnsplashForKakaoPay
//
//  Created by mmxsound on 2020/10/24.
//

import UIKit

struct EccessToken : Codable {
    let access_token: String?
    let token_type: String?
    let scope: String?
    let created_at: Int?
    
    enum CodingKeys: String, CodingKey {

        case access_token = "access_token"
        case token_type = "token_type"
        case scope = "scope"
        case created_at = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
        token_type = try values.decodeIfPresent(String.self, forKey: .token_type)
        scope = try values.decodeIfPresent(String.self, forKey: .scope)
        created_at = try values.decodeIfPresent(Int.self, forKey: .created_at)
    }
}

struct UnsplashSearch : Codable {
    let total: Int?
    let total_pages: Int?
    let results: [Unsplash]?
    
    enum CodingKeys: String, CodingKey {

        case total = "total"
        case total_pages = "total_pages"
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        results = try values.decodeIfPresent([Unsplash].self, forKey: .results)
    }
}

struct Unsplash : Codable {
    
    let id : String?
    let created_at : String?
    let updated_at : String?
    let promoted_at : String?
    let width : Int?
    let height : Int?
    let color : String?
    let description : String?
    let alt_description : String?
    let urls : Urls?
    let links : Links?
    let categories : [String]?
    let likes : Int?
    let liked_by_user : Bool?
    let current_user_collections : [String]?
    let sponsorship : Sponsorship?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case promoted_at = "promoted_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case description = "description"
        case alt_description = "alt_description"
        case urls = "urls"
        case links = "links"
        case categories = "categories"
        case likes = "likes"
        case liked_by_user = "liked_by_user"
        case current_user_collections = "current_user_collections"
        case sponsorship = "sponsorship"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        promoted_at = try values.decodeIfPresent(String.self, forKey: .promoted_at)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        alt_description = try values.decodeIfPresent(String.self, forKey: .alt_description)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        liked_by_user = try values.decodeIfPresent(Bool.self, forKey: .liked_by_user)
        current_user_collections = try values.decodeIfPresent([String].self, forKey: .current_user_collections)
        sponsorship = try values.decodeIfPresent(Sponsorship.self, forKey: .sponsorship)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}

struct Links : Codable {
    let html : String?
    let photos : String?
    let likes : String?
    let portfolio : String?
    let following : String?
    let followers : String?

    enum CodingKeys: String, CodingKey {

        case html = "html"
        case photos = "photos"
        case likes = "likes"
        case portfolio = "portfolio"
        case following = "following"
        case followers = "followers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        photos = try values.decodeIfPresent(String.self, forKey: .photos)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        portfolio = try values.decodeIfPresent(String.self, forKey: .portfolio)
        following = try values.decodeIfPresent(String.self, forKey: .following)
        followers = try values.decodeIfPresent(String.self, forKey: .followers)
    }

}

struct Profile_image : Codable {
    let small : String?
    let medium : String?
    let large : String?

    enum CodingKeys: String, CodingKey {

        case small = "small"
        case medium = "medium"
        case large = "large"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        large = try values.decodeIfPresent(String.self, forKey: .large)
    }

}

struct Sponsor : Codable {
    let id : String?
    let updated_at : String?
    let username : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let twitter_username : String?
    let portfolio_url : String?
    let bio : String?
    let location : String?
    let links : Links?
    let profile_image : Profile_image?
    let instagram_username : String?
    let total_collections : Int?
    let total_likes : Int?
    let total_photos : Int?
    let accepted_tos : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case updated_at = "updated_at"
        case username = "username"
        case name = "name"
        case first_name = "first_name"
        case last_name = "last_name"
        case twitter_username = "twitter_username"
        case portfolio_url = "portfolio_url"
        case bio = "bio"
        case location = "location"
        case links = "links"
        case profile_image = "profile_image"
        case instagram_username = "instagram_username"
        case total_collections = "total_collections"
        case total_likes = "total_likes"
        case total_photos = "total_photos"
        case accepted_tos = "accepted_tos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        twitter_username = try values.decodeIfPresent(String.self, forKey: .twitter_username)
        portfolio_url = try values.decodeIfPresent(String.self, forKey: .portfolio_url)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
        profile_image = try values.decodeIfPresent(Profile_image.self, forKey: .profile_image)
        instagram_username = try values.decodeIfPresent(String.self, forKey: .instagram_username)
        total_collections = try values.decodeIfPresent(Int.self, forKey: .total_collections)
        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
        total_photos = try values.decodeIfPresent(Int.self, forKey: .total_photos)
        accepted_tos = try values.decodeIfPresent(Bool.self, forKey: .accepted_tos)
    }

}

struct Sponsorship : Codable {
    let impression_urls : [String]?
    let tagline : String?
    let tagline_url : String?
    let sponsor : Sponsor?

    enum CodingKeys: String, CodingKey {

        case impression_urls = "impression_urls"
        case tagline = "tagline"
        case tagline_url = "tagline_url"
        case sponsor = "sponsor"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        impression_urls = try values.decodeIfPresent([String].self, forKey: .impression_urls)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        tagline_url = try values.decodeIfPresent(String.self, forKey: .tagline_url)
        sponsor = try values.decodeIfPresent(Sponsor.self, forKey: .sponsor)
    }

}

struct Urls : Codable {
    let raw : String?
    let full : String?
    let regular : String?
    let small : String?
    let thumb : String?

    enum CodingKeys: String, CodingKey {

        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        raw = try values.decodeIfPresent(String.self, forKey: .raw)
        full = try values.decodeIfPresent(String.self, forKey: .full)
        regular = try values.decodeIfPresent(String.self, forKey: .regular)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
    }

}

struct User : Codable {
    let id : String?
    let updated_at : String?
    let username : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let twitter_username : String?
    let portfolio_url : String?
    let bio : String?
    let location : String?
    let links : Links?
    let profile_image : Profile_image?
    let instagram_username : String?
    let total_collections : Int?
    let total_likes : Int?
    let total_photos : Int?
    let accepted_tos : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case updated_at = "updated_at"
        case username = "username"
        case name = "name"
        case first_name = "first_name"
        case last_name = "last_name"
        case twitter_username = "twitter_username"
        case portfolio_url = "portfolio_url"
        case bio = "bio"
        case location = "location"
        case links = "links"
        case profile_image = "profile_image"
        case instagram_username = "instagram_username"
        case total_collections = "total_collections"
        case total_likes = "total_likes"
        case total_photos = "total_photos"
        case accepted_tos = "accepted_tos"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        twitter_username = try values.decodeIfPresent(String.self, forKey: .twitter_username)
        portfolio_url = try values.decodeIfPresent(String.self, forKey: .portfolio_url)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
        profile_image = try values.decodeIfPresent(Profile_image.self, forKey: .profile_image)
        instagram_username = try values.decodeIfPresent(String.self, forKey: .instagram_username)
        total_collections = try values.decodeIfPresent(Int.self, forKey: .total_collections)
        total_likes = try values.decodeIfPresent(Int.self, forKey: .total_likes)
        total_photos = try values.decodeIfPresent(Int.self, forKey: .total_photos)
        accepted_tos = try values.decodeIfPresent(Bool.self, forKey: .accepted_tos)
    }

}
