//
//  AppCore.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import Foundation
import ComposableArchitecture
import Combine

struct AppState: Equatable {
    var commentState: CommentsState
    
    
}

enum AppAction {
    case commentAction(CommentsAction)
}

struct AppEnvironment {
    var getComments : Effect<[Comments],ProviderError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
}


let appRedducer : Reducer<AppState, AppAction, AppEnvironment> = .combine(
    commentsReducer.pullback(
        state: \.commentState,
        action: /AppAction.commentAction,
        environment:  { environment in
            CommentsEnvironments(getComments:
                                environment.getComments,
                                 mainQueue: environment.mainQueue
            )
        }
    ),
    .init
    {
        state, action, env in
        return .none
    })

