//
//  Model.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import Foundation
import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds

struct User: Identifiable{
    let id = UUID()
    var username: String
    var email: String
    var password: String
    var name: String
    var bio: String
    var followers: Int
    var following: Int
    var postCount: Int
    
}

enum SFSymbols {
    static let heart = Image(systemName: "heart")
    static let heartFilled = Image(systemName: "heart.fill")
    static let shareIOS = Image(systemName: "square.and.arrow.up")
    static let shareIG = Image(systemName: "paperplane")
    static let comment = Image(systemName: "bubble.right")
    static let bookmark = Image(systemName: "bookmark")
    static let bookmarkFilled = Image(systemName: "bookmark.fill")
    static let camera = Image(systemName: "camera")
    //bottom menu symbols:
    static let profile = Image(systemName: "person.crop.circle")
    static let profileFilled = Image(systemName: "person.crop.circle.fill")
    static let addPost = Image(systemName: "plus.app")
    static let addPostFilled = Image(systemName: "plus.app.fill")
    static let explore = Image(systemName: "magnifyingglass")
    static let home = Image(systemName: "house")
    static let homeFilled = Image(systemName: "house.fill")
    
    static let dots = Image(systemName: "ellipsis")
    
    static let lock = Image(systemName: "lock")
    static let mail = Image(systemName: "mail")
}

enum Page{
    case home
    case profile
}
