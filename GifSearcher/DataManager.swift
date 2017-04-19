//
//  DataManager.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/17/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import Foundation
import SwiftyJSON

final class DataManager {
  static let instance = DataManager()
  private init() { }
  
  private let imageType = "fixed_width"
  
  func GifsFromJson(with objectNotation: JSON) -> [Gif] {
    guard objectNotation.count != 0 else {
      return []
    }
    var gifs = [Gif]()
    for (_, json) in objectNotation {
      let url = json["images"][imageType]["url"].url
      let width = json["images"][imageType]["width"].string
      let height = json["images"][imageType]["height"].string
      let rating = json["rating"].string
      let wasTrended = (json["trending_datetime"].string) != nil
      if let url = url, let rating = rating, let height = Float(height!), let width = Float(width!) {
        let gif = Gif(url: url, height: height, width: width, wasTrended: wasTrended, rating: rating)
        gifs.append(gif)
      }
    }
    return gifs
  }
}
