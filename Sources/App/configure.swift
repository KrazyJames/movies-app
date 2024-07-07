import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) async throws {

    // MARK: - DB Config
    app.databases.use(
        .postgres(
            configuration: .init(
                hostname: "localhost",
                // If no username was provided, the computer's username is the default
                username: "thekrazyjames"
            )
        ),
        as: .psql
    )

    // MARK: - Register Migrations
    app.migrations.add(CreateMoviesTableMigration())

    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // register routes
    try routes(app)
}
