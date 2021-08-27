//
//  Router+Video.swift
//  itodayetp (iOS)
//
//  Created by gaurav.mishra on 06/08/21.
//

import Foundation

extension Router {
    static func getLanding(id:String) -> VideoRoute {
    return
      VideoRoute(
        path: "/api/v1/data/\(id)",
        queryItems:[URLQueryItem(name: "_format", value: "json")]
      )
  }
}
