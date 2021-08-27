//
//  AppView.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import SwiftUI
import ComposableArchitecture
struct AppView: View {
    let store : Store<AppState, AppAction>
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView{
                TabView{
                    IfLetStore(
                        store.scope(state: \.commentsState, action: AppAction.commentAction),
                        then: CommentsView.init(store:),
                      else: {
                       
                        Text("Loading search results...")
                            .onAppear(perform: {
                                viewStore.send(AppAction.loadComments)
                            })
                      }
                    )
                        .tabItem{
                            Image(systemName: "message")
                            Text("Comments")
                        }
                    
                    PostComments()
                        .tabItem{
                            Image(systemName: "plus")
                            Text("Comments")
                        }
                }
                .navigationBarTitle("Messages")
                .navigationBarTitleDisplayMode(.inline)
            }

        }
    }
}

//struct AppView_Previews: PreviewProvider {
//    static var previews: some View {
//
//
//        AppView(store: Store(initialState: AppState(commentState: CommentsState()), reducer: appRedducer, environment: AppEnvironment(getComments: Provider.shared.getComments.eraseToEffect(), mainQueue: .main)))
//    }
//}
