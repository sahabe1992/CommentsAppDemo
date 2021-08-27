//
//  Repository.swift
//  CcomposeAPISample
//
//  Created by Srijan on 27/08/21.
//

import Foundation
import ComposableArchitecture

class CommentsRepository {
    func getAll() -> Effect<[Comments], ProviderError>  {
        Provider.shared.getComments().eraseToEffect()
    }
}
