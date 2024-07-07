//
//  Movie.swift
//
//
//  Created by Jimmy on 06/07/24.
//

import Foundation
import Fluent
import Vapor

/// https://blog.vapor.codes/posts/fluent-models-and-sendable/
final class Movie: Model, Content, @unchecked Sendable {
    static let schema: String = "movies"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    init() { }

    init(
        id: UUID? = nil,
        title: String
    ) {
        self.id = id
        self.title = title
    }
}
