import Vapor

func routes(_ app: Application) throws {
    // MARK: - Create
    app.post("movies") { req async throws in
        let movie = try req.content.decode(Movie.self)
        try await movie.save(on: req.db)
        return movie
    }

    // MARK: - Read
    app.get("movies") { req async throws in
        try await Movie.query(on: req.db)
            .all()
    }

    app.get("movies", ":id") { req async throws in
        guard let movie = try await Movie.find(
            req.parameters.get("id"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        return movie
    }

    // MARK: - Delete
    app.delete("movies", ":id") { req async throws in
        guard let movie = try await Movie.find(
            req.parameters.get("id"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        try await movie.delete(on: req.db)
        return movie
    }

    // MARK: - Update
    app.put("movies") { req async throws in
        let new = try req.content.decode(Movie.self)
        guard let old = try await Movie.find(
            new.id,
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        old.title = new.title
        try await old.update(on: req.db)
        return old
    }
}
