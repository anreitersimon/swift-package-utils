import Foundation
import PackagePlugin

struct ArtifactBundle: Codable {

    struct Artifact: Codable {
        var version: String
        var type: String
        var variants: [Variant]

        struct Variant: Codable {
            var path: String
            var supportedTriples: [String]
        }
    }

    struct Info: Codable {
        var schemaVersion = "1.0"
        var artifacts: [String: Artifact]
    }

    struct Builder {
        let url: URL
        let version: String
        var info: Info = Info(artifacts: [:])

        mutating func addArtifact(
            _ artifact: PackageManager.BuildResult.BuiltArtifact,
            additionalFiles: [String]
        ) throws {
            let name = artifact.path.stem
            let artifactURL = URL(fileURLWithPath: artifact.path.string)
            let path = "\(name)-\(version)-macos/bin/\(name)"
            let targetDirectoryURL = url.appendingPathComponent("\(name)-\(version)-macos/bin")

            let targetURL = targetDirectoryURL.appendingPathComponent(name)

            try FileManager.default.createDirectory(
                at: targetURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )

            try FileManager.default.copyItem(
                at: artifactURL,
                to: targetURL
            )
            
            for file in additionalFiles {
                let url = URL(fileURLWithPath: file)
                
                try FileManager.default.copyItem(
                    at: url,
                    to: targetDirectoryURL.appendingPathComponent(url.lastPathComponent)
                )
            }

            info.artifacts[name] = ArtifactBundle.Artifact(
                version: version,
                type: "executable",
                variants: [
                    .init(
                        path: path,
                        supportedTriples: [
                            "x86_64-apple-macosx",
                            "arm64-apple-macosx",
                        ]
                    )
                ]
            )
        }

        func save() throws {
            let encoder = JSONEncoder()

            let data = try encoder.encode(info)

            try data.write(to: url.appendingPathComponent("info.json"))
        }
    }
}
