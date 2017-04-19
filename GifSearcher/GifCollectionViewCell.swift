//
//  GifCollectionViewCell.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/17/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var gifImageView: UIImageView!
  @IBOutlet weak var ratedImageView: UIImageView!
  
  var gif: Gif? {
    didSet {
      if let url = gif?.url {
        DispatchQueue.global().async {
          let data = try? Data(contentsOf: url)
          DispatchQueue.main.async {
            if let data = data {
              self.gifImageView.image = UIImage.gif(data: data)
              self.denoteRated(self.gif!)
            }
          }
        }
      }
    }
  }
  
  private func denoteRated(_ gif: Gif) {
    if gif.wasTrended {
      ratedImageView.image = UIImage(named: "star")
    } else {
      ratedImageView.isHidden = true
    }
    
  }
}
