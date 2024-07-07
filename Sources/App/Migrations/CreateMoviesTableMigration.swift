//
//  CreateMoviesTableMigration.swift
//
//
//  Created by Jimmy on 06/07/24.
//

import Foundation
import Fluent

struct CreateMoviesTableMigration: AsyncMigration {
    /// Make a change to the database.
    func prepare(on database: Database) async throws {
        try await database
            .schema("movies")
            .id()
            .field(
                "title",
                .string,
                .required
            )
            .create()
    }

    /// Undo the change made in `prepare`, if possible.
    func revert(on database: Database) async throws {
        try await database
            .schema("movies")
            .delete()
    }
}
