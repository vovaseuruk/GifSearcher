//
//  Constants.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/19/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import Foundation
import UIKit

final class Constants {
  static let familyRatings: Set = ["y", "g", "pg"]
  static let avenirFont = UIFont.init(name: "AvenirNextCondensed-Light", size: 16.0)
  
  struct GiphyRequest {
    static let searchBase = "http://api.giphy.com/v1/gifs/search?"
    static let trendingBase = "http://api.giphy.com/v1/gifs/trending?"
    static let searchTerm = "q"
  }
  
  struct GifCollection {
    static let itemsPerRow: CGFloat = 3
    static let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    static let padding: CGFloat = 10
  }
}
