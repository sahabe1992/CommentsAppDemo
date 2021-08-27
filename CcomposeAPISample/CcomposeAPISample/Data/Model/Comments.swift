//
//  Model.swift
//  Meconnect Login
//
//  Created by Srijan on 04/08/21.
//

import Foundation
struct Comments: Codable, Equatable, Identifiable {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?    
}


