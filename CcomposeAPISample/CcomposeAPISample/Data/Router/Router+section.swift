//
//  Router+section.swift
//  itodayetp (iOS)
//
//  Created by chanchal.kumari on 06/08/21.
//

import Foundation

extension Router {

 static func sectionPage() -> Route {
      return
        Route(
          path: "/api/v2/component/0a8fbb69-8a67-450b-ab9e-15c2b678f897",
            queryItems: [
              .init(name: "viewMode", value: "a_left_5s_5p_ads"),
            ]
        )
    }
}
