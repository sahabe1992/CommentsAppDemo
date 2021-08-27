//
//  Provider+Section.swift
//  itodayetp (iOS)
//
//  Created by chanchal.kumari on 06/08/21.
//

import Foundation
import Combine
import Foundation

extension Provider {
    func getComments() -> AnyPublisher<[Comments], ProviderError>{
    var request = URLRequest(url: Router.getComments().url!)
    request.httpMethod = "GET"
    return requestPublisher(request)
  }
}
