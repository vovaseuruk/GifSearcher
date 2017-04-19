//
//  GIFCollectionViewController.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/17/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftGifOrigin

class GIFCollectionViewController: UICollectionViewController {
  let reuseIdentifier = "Gif Cell"
  var gifs = [Gif]()
  var searchTerm = ""
  
  func searchForGifs(with searchTerm: String = "") {
    NetworkManager.instance.delegate = self
    NetworkManager.instance.fetchGifs(with: searchTerm)
  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gifs.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let gifCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCollectionViewCell
    let gif = gifs[indexPath.row]
    gifCell.gif = gif
    
    return gifCell
  }
}

//MARK: NetworkManagerDelegate
extension GIFCollectionViewController: NetworkManagerDelegate {
  func didReceive(gifs: [Gif]) {
    self.gifs = gifs
    collectionView?.reloadData()
  }
  
  func gifsFetchingFailed(with error: Error) {
    print(error)
  }
}

//MARK: UICollectionViewDelegateFlowLayout
extension GIFCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let paddingSpace = Constants.GifCollection.padding * (Constants.GifCollection.itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerGif = availableWidth / Constants.GifCollection.itemsPerRow
    return CGSize(width: widthPerGif, height: widthPerGif)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constants.GifCollection.sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.GifCollection.padding
  }
}

