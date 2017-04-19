//
//  Gif.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/18/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import Foundation

final class Gif {
  let url: URL
  let height: Float
  let width: Float
  let wasTrended: Bool
  let isFamilyFriendly: Bool
  
  init(url: URL, height: Float, width: Float, wasTrended: Bool, rating: String) {
    self.url = url
    self.height = height
    self.width = width
    self.wasTrended = wasTrended
    isFamilyFriendly = (Constants.familyRatings.contains(rating) ? true : false)
  }
}
