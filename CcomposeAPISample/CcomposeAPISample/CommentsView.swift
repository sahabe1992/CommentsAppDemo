//
//  CommentsView.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import SwiftUI
import ComposableArchitecture
struct CommentsView: View {
    let store: Store<CommentsState, CommentsAction>
    var body: some View {
        WithViewStore(self.store) { viewstore in
            VStack {
                commentsList(viewstore)
            }
        }
        
    }
}

extension CommentsView {
    @ViewBuilder
    private func commentsList(_ viewStore: ViewStore<CommentsState, CommentsAction>) -> some View {
        ForEachStore(
            store.scope(
                state: { $0.comments },
                action: CommentsAction.detailAction(id:action:)
            ),
            content: { cardStore in
                WithViewStore(cardStore) { cardViewStore in
                    NavigationLink(
                        destination: CommentsDetail(store: cardStore),
                        label: {
                            Text(cardViewStore.state.comment.email ?? "")
                        }
                    )
                }
            }
        )
    }
}

//struct CommentsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsView(store: <#Store<CommentsState, CommentsAction>#>)
//    }
//}


struct CommentsState: Equatable {
    var comments = IdentifiedArrayOf<DetailState>()
}

enum CommentsAction {
    case detailAction(id: UUID, action: DetailAction)
    
}
struct CommentsEnvironments {
    var getComments : ()-> Effect<[Comments],ProviderError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


let commentsReducer = Reducer<CommentsState, CommentsAction, CommentsEnvironments>  { state, action, environment in
    struct CardsCancelId: Hashable {}
    switch action{
    case .detailAction(_, _):
        print("card detail action")
    }
    
    return .none
}


enum CommentLoadingState:Equatable {
    case NotLoaded
    case Loading
    case Loadded(CommentsState)
   
}

