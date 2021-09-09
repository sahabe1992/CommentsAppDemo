//
//  CommentsDetail.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import SwiftUI
import ComposableArchitecture
struct CommentsDetail: View {
    let store: Store<DetailState, DetailAction>
    
    var body: some View {
        WithViewStore(store) { viewstore in
            Text(viewstore.comment.email ?? "")
            Button("Hello World") {
                print(type(of: self.body))

            }
            .frame(width: 200, height: 200)
            .background(Color.red)
        }
       
    }
}

//struct CommentsDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentsDetail()
//    }
//}


struct DetailState: Equatable, Identifiable {
    var id: UUID
    var comment: Comments
    
    
}


enum DetailAction {
    case postComments
}

struct DetailEnvironment {
}
let detailReducer = Reducer<DetailState, DetailAction, DetailEnvironment> {
    state, action, environment in
    return .none
}

