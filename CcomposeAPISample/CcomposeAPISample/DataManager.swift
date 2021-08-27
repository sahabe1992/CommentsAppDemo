//
//  DataManager.swift
//  CcomposeAPISample
//
//  Created by Srijan on 27/08/21.
//

import Foundation
class DataManager {
    let commentsRepo:  CommentsRepository
    init( commentsRepository: CommentsRepository = CommentsRepository()) {
        self.commentsRepo = commentsRepository
    }
}
