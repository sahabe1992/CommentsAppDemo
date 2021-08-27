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
            }.onAppear{
                viewstore.send(.loadComments)
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
                action: CommentsAction.card(id:action:)
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
    case loadComments
    case onResponseReceive(Result<[Comments], ProviderError>)
    case card(id: UUID, action: DetailAction)
    
}
struct CommentsEnvironments {
    var getComments : Effect<[Comments],ProviderError>
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


let commentsReducer = Reducer<CommentsState, CommentsAction, CommentsEnvironments>  { state, action, environment in
    struct CardsCancelId: Hashable {}
    switch action{
    case .loadComments:
        print("Comments")
        return .concatenate(
            environment.getComments
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(CommentsAction.onResponseReceive)
                .cancellable(id: CardsCancelId()))
    case .onResponseReceive(.success(let commonts)):
        print(commonts)
        let cardItems = IdentifiedArrayOf<DetailState>(
            uniqueElements: commonts.map {
                DetailState(id: UUID(), comment: $0)
            }
        )
        state.comments = cardItems
    case .onResponseReceive(.failure(let error)):
        print(error)
    case .card(_, _):
        print("card detail action")
    }
    
    return .none
}


struct LoadStatus<T> {
    var loaded: T
    var Loading: T
    var notLoadded: T
}

