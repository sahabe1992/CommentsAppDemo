//
//  Router.swift
//  Meconnect Login
//
//  Created by Srijan on 04/08/21.
//

import Foundation

struct Route {
  let path: String
  let queryItems: [URLQueryItem]?

  init(path: String, queryItems: [URLQueryItem]? = nil) {
    self.path = path
    self.queryItems = queryItems
  }

  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "jsonplaceholder.typicode.com"
    components.path = path
    components.queryItems = queryItems
    print(components.url)
    return components.url
  }

    var sectionPageurl: URL? {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "stg-www.todayonline.com"
      components.path = path
      components.queryItems = queryItems
      return components.url
    }
}

struct Router {}

struct VideoRoute {
  let path: String
  let queryItems: [URLQueryItem]?

  init(path: String, queryItems: [URLQueryItem]? = nil) {
    self.path = path
    self.queryItems = queryItems
  }

  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "stg-www.todayonline.com"
    components.path = path
    components.queryItems = queryItems
    print(components.url)
    return components.url
  }
}


extension String {
    var urlEncoded: String? {
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_.?"))
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
