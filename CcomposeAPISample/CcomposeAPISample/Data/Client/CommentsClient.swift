//
//  LoginClient.swift
//  Meconnect Login
//
//  Created by Srijan on 04/08/21.
//

import Foundation
import ComposableArchitecture
struct LoginClient {
    var getComments:(
    ) -> Effect<[Comments], ProviderError>
}

extension LoginClient {
    static let live = LoginClient {
        Provider.shared.getComments().eraseToEffect()
    }
}
