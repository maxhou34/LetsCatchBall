import Fluent
import Leaf
import Vapor

func routes(_ app: Application) throws {
  app.get { _ async in
    "It works!"
  }

  app.get("hello") { _ async -> String in
    "Hello, world!"
  }

  try app.register(collection: UserModelController())
  try app.register(collection: AccountCheckController())
  try app.register(collection: AuthController())
  try app.register(collection: ActivityModelController())
  try app.register(collection: HtmlController())
}
