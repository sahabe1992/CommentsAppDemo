//
//  PostComments.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import SwiftUI
import ComposableArchitecture
struct PostComments: View {
    let store: Store<PostCommentState, PostCommentAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                TextField("User Name", text: viewStore.binding(keyPath: \.userName, send: PostCommentAction.postComment))
                TextField("Email", text: viewStore.binding(keyPath: \.email, send: PostCommentAction.postComment))
            }
        }
       
    }
}

//struct PostComments_Previews: PreviewProvider {
//    static var previews: some View {
//        PostComments()
//    }
//}


struct PostCommentState: Equatable {
    var userName = ""
    var email = ""
}

enum PostCommentAction {
    case postComment(BindingAction<PostCommentState>) //https://www.pointfree.co/blog/posts/52-composable-forms-say-bye-to-boilerplate
}
struct Environment {
    
}
let settingsReducer = Reducer<
    PostCommentState, PostCommentAction, Environment
> {state,action,env in
  switch action {
  case .postComment(\.userName):
    print("ddd\(state.userName)")
  case .postComment(\.email):
    print("ddd\(state.email)")
  case .postComment(_):
    break
  }
    return .none
   
}
.binding(action: /PostCommentAction.postComment)

