import PackageDescription

let package = Package(
    name: "Scraper",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 6),
        .Package(url: "https://github.com/IBM-Swift/Swift-Kuery.git", majorVersion: 0, minor: 7),
        .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2, minor: 1),
    ]
)
