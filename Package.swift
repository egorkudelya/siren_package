// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "siren_package",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "siren_package",
            targets: ["siren_package"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "miniaudio",
            path: "Sources/objc_miniaudio",
            sources: ["miniaudio.m"],
            publicHeadersPath: "",
            cSettings: [
                .unsafeFlags(["-O3"])
            ]
        ),
        .target(
            name: "kissfft",
            path: "Sources/siren_core/vendor/kissfft",
            exclude: ["test"],
            sources: ["kiss_fft.c"],
            publicHeadersPath: "",
            cSettings: [
                .unsafeFlags(["-O3"])
            ]
        ),
        .target(
            name: "ObjCSiren",
            dependencies: ["miniaudio", "kissfft"],
            path: "Sources/",
            exclude: [
                "siren_core/vendor/googletest",
                "siren_core/vendor/kissfft",
                "siren_core/vendor/miniaudio",
                "siren_core/test",
                "siren_core/CMakeLists.txt",
            ],
            sources: [
                "objc/",
                "siren_core/src/",
                "siren_core/src/client_wrapper",
                "siren_core/src/common",
                "siren_core/src/decoder",
                "siren_core/src/entities",
                "siren_core/src/fft",
                "siren_core/src/serializer",
            ],
            publicHeadersPath: "objc/",
            cxxSettings: [
                .unsafeFlags(["-O3"]),
                .headerSearchPath("objc/include"),
                .headerSearchPath("siren_core/src/"),
                .headerSearchPath("siren_core/src/client_wrapper"),
                .headerSearchPath("siren_core/vendor/eigen"),
            ]
          ),
        .target(
            name: "siren_package",
            dependencies: ["ObjCSiren"],
            path: "Sources/siren_package"
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["siren_package"],
            path: "Tests/siren_packageTests"
        )
    ],
    
    cLanguageStandard: CLanguageStandard.c11,
    cxxLanguageStandard: CXXLanguageStandard.cxx17
)
