//
//  SeachedGifsViewController.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/19/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import UIKit

final class SeachedGifsViewController: GIFCollectionViewController {
  private var familyMode: UIButton!
  override var gifs: [Gif] { didSet{ createFamilyGifsArray() } }
  var familyFriendlyGifs: [Gif]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchForGifs(with: searchTerm)
    
    configureFamilyModeButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    configureConstraints()
  }
  
  private func createFamilyGifsArray() {
    familyFriendlyGifs = gifs.filter { gif in return gif.isFamilyFriendly }
  }
  
  //MARK: FamilyMode Button
  private func configureFamilyModeButton() {
    familyMode = UIButton()
    familyMode.addTarget(self, action: #selector(familyModeTapped), for: .touchUpInside)
    familyMode.setImage(UIImage(named: "familyMode"), for: .normal)
    familyMode.setImage(UIImage(named: "adultMode"), for: .selected)
    familyMode.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(familyMode)
  }
  
  private var inFamilyMode = false
  
  @objc private func familyModeTapped() {
    inFamilyMode = !inFamilyMode
    familyMode.isSelected = inFamilyMode
    collectionView?.reloadData()
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (inFamilyMode ? familyFriendlyGifs!.count : gifs.count)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let gifCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCollectionViewCell
    let source = (inFamilyMode ? familyFriendlyGifs! : gifs)
    let gif = source[indexPath.row]
    gifCell.gif = gif
    
    return gifCell
  }
  
  //MARK: Constraints
  private func configureConstraints() {
    let descVertical = "V:[button(64)]-10-|"
    let viewsDict = ["button": familyMode]
    
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical,
                                                             options: NSLayoutFormatOptions(rawValue: 0),
                                                             metrics: nil,
                                                             views: viewsDict)
    NSLayoutConstraint(item: familyMode,
                       attribute: .centerX,
                       relatedBy: .equal,
                       toItem: self.view,
                       attribute: .centerX,
                       multiplier: 1.0,
                       constant: 0).isActive = true
    
    self.view.addConstraints(verticalConstraints)
  }
}

