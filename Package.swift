import PackageDescription

let package = Package(
    name: "Scraper",
    targets: [
      Target(name: "Scraper"),
      Target(name: "swiftkiq-service",
          dependencies: [
            .Target(name: "Scraper")
          ]
        )
      ],
      dependencies: [
          .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
          .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
          .Package(url: "https://github.com/IBM-Swift/Kitura-MustacheTemplateEngine.git", majorVersion: 1, minor: 6),
          .Package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", majorVersion: 0, minor: 6),
          .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2, minor: 1),
          .Package(url: "https://github.com/radioboo/Swiftkiq.git", majorVersion: 0)
    ]
)
