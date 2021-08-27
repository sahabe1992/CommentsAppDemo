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
                    CommentsView(store: self.store.scope(state: \.commentState, action: AppAction.commentAction))
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

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
       
        
        AppView(store: Store(initialState: AppState(commentState: CommentsState()), reducer: appRedducer, environment: AppEnvironment(getComments: Provider.shared.getComments().eraseToEffect(), mainQueue: .main)))
    }
}
