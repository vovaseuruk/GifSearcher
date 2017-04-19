//
//  NetworkManager.swift
//  GifSearcher
//
//  Created by Vova Seuruk on 4/17/17.
//  Copyright © 2017 Vova Seuruk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkManagerDelegate: class {
  func didReceive(gifs: [Gif])
  func gifsFetchingFailed(with error: Error)
}

final class NetworkManager {
  static let instance = NetworkManager()
  private init() {}
  
  weak var delegate: NetworkManagerDelegate?
  private let dataManager = DataManager.instance

  public func fetchGifs(with name: String = "") {
    let completedRequest = buildSearchRequest(with: name)
    Alamofire.request(completedRequest, parameters: parameters).responseJSON { [weak self] response in
      switch response.result {
      case .success(let jsonNotation):
          let gifsArray = (jsonNotation as! [String:Any])["data"] as! [Any]
          self?.delegate?.didReceive(gifs: (self?.dataManager.GifsFromJson(with: JSON(gifsArray)))!)
      case .failure(let err):
          self?.delegate?.gifsFetchingFailed(with: err)
      }
    }
  }
  
  private func buildSearchRequest(with request: String) -> String {
    guard request.characters.count > 0 else {
      return Constants.GiphyRequest.trendingBase
    }
    parameters[Constants.GiphyRequest.searchTerm] = request
    return Constants.GiphyRequest.searchBase
  }
  
  private var parameters: Parameters = [
    "api_key": "dc6zaTOxFJmzC"
  ]
}
