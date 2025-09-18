// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "SurgeHTTPAPI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17)
    ],
    products: [
        .library(
            name: "SurgeHTTPAPI",
            targets: ["SurgeHTTPAPI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.2"),
        .package(url: "https://github.com/sindresorhus/Defaults.git", from: "9.0.3")
    ],
    targets: [
        .target(
            name: "SurgeHTTPAPI",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SwiftyJSON", package: "SwiftyJSON"),
                .product(name: "Defaults", package: "Defaults")
            ]
        ),
        .testTarget(
            name: "SurgeHTTPAPITests",
            dependencies: ["SurgeHTTPAPI"]
        )
    ]
)
