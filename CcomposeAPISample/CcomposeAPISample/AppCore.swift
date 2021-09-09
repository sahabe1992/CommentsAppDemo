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
    var commentState: CommentLoadingState
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
    
    var postCommentState: PostCommentState
    
    
    
}

enum AppAction {
    case commentAction(CommentsAction)
    case loadComments
    case commentsLoaded([Comments])
    case postComment(PostCommentAction)
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
    settingsReducer.pullback(
        state: \.postCommentState,
        action: /AppAction.postComment,
        environment:  { environment in
            Environment()
        }
    ),
    .init
    {
        state, action, env in
        switch action {
        case .loadComments: return env
            .getComments()
            .receive(on: env.mainQueue)
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
            state.commentState = CommentLoadingState.Loadded(
                CommentsState.init(comments:cardItems)
            )
            return .none
        default: return .none
        }
    })

