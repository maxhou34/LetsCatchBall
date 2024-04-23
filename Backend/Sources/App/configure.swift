import Fluent
import FluentPostgresDriver
import Leaf
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
//  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  app.logger.logLevel = .debug

  app.logger.info("Logging to Console")

  try app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
    hostname: Environment.get("DATABASE_HOST") ?? "localhost",
    port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
    username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
    password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
    database: Environment.get("DATABASE_NAME") ?? "vapor_database",
    tls: .prefer(.init(configuration: .clientDefault)))
  ), as: .psql)

  app.migrations.add(UserModelMigration())
  app.migrations.add(ActivityModelMigration())
//  app.migrations.add(ChatroomModelMigration())
//  app.migrations.add(TotalModelMigration())

  try await app.autoMigrate()
//  try await app.autoRevert()

  app.views.use(.leaf)
  app.leaf.configuration.rootDirectory = app.directory.viewsDirectory
  print()

  // register routes
  try routes(app)
}
