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
    
    var commentState: CommentState
    
    var commentsState: CommentsState?{
        get {
            switch commentState {
                case .Loadded(let commentsState):
                    return commentsState
                default:
                    return nil
            }
        }
        
        set {
            if (newValue == nil){
                commentState = .NotLoaded
            } else {
                commentState = .Loadded(newValue!)
            }
        }
    }
    
    
}

enum AppAction {
    case commentAction(CommentsAction)
    case loadComments
    case commentsLoaded([Comments])
}

struct AppEnvironment {
    var getComments : ()-> Effect<[Comments],ProviderError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
}


let appRedducer : Reducer<AppState, AppAction, AppEnvironment> = .combine(
    commentsReducer.optional().pullback(
        state: \.commentsState,
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
        switch action {
        case .loadComments: return env
            .getComments()
            .catchToEffect({
                            result in
                            AppAction.commentsLoaded(
                                    try! result.get()
                            )
            })
        case .commentsLoaded(let comments):
            let cardItems = IdentifiedArrayOf<DetailState>(
                uniqueElements: comments.map {
                    DetailState(id: UUID(), comment: $0)
                }
            )
            state.commentState = CommentState.Loadded(
                CommentsState.init(comments:cardItems)
            )
            return .none
        default: return .none
        }
    })

