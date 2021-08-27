//
//  CcomposeAPISampleApp.swift
//  CcomposeAPISample
//
//  Created by Srijan on 26/08/21.
//

import SwiftUI
import ComposableArchitecture
@main
struct CcomposeAPISampleApp: App {
    let dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppState(commentState: CommentState.Loading), reducer: appRedducer, environment: AppEnvironment(getComments: dataManager.commentsRepo.getAll, mainQueue: .main)))
        }
    }
}
