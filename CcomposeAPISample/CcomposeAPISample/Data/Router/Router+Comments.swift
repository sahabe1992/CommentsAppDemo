//
//  Router+Login.swift
//  Meconnect Login
//
//  Created by Srijan on 04/08/21.
//

import Foundation

extension Router {
    static func getComments() -> Route {
    return
      Route(
        path: "/posts/1/comments",
        queryItems: nil
      )
  }
}
