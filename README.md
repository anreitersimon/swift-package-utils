# PackageUtils

Contains Utilites for working with SwiftPackageManager.

## Installing 

Add this to the dependencies section of your `Package.swift`

```
    dependencies: [
        .package(
            url: "https://github.com/anreitersimon/swift-package-utils",
            branch: "main"
        ),
    ]
```



## Plugins

### CreateArtifactBundle

```shell
swift package create-artifact-bundle\
 --archive-name <archive-name>\                     # optional: will use "${package.displayName}-${version}" by default
 --package-version 1.0.0\                           # required
 --product <product-name> --produt <product-name 2> # you can pass multiple products here
```

This will generate a artifact bundle at `.build/plugins/CreateArtifactBundle/outputs/<archive-name>.zip`
