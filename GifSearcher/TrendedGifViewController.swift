//
//  GifSearcherViewController.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/19/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftGifOrigin

final class TrendedGifViewController: GIFCollectionViewController {
  
  var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchForGifs()
    
    configureSearchField()
    addCancelOnTapGesture()
  }
  
  private func configureSearchField() {
    searchBar = UISearchBar()
    searchBar.placeholder = "Search..."
    searchBar.delegate = self
    let textField = searchBar.value(forKey: "searchField") as? UITextField
    textField?.font = Constants.avenirFont
    self.navigationItem.titleView = searchBar
  }
  
  private func addCancelOnTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func dismissKeyboard() {
    self.searchBar.resignFirstResponder()
  }
}

//MARK: UISearchBarDelegate
extension TrendedGifViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    let searchGifsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeachedGifsViewController")
      as! SeachedGifsViewController
    searchGifsVC.navigationItem.title = searchBar.text?.uppercased()
    searchGifsVC.searchTerm = searchBar.text!
    self.navigationController?.pushViewController(searchGifsVC, animated: false)
  }
}
