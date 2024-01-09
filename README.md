# Mono Repository PoC

This repository aims to represent basic mono repository implementation

Local packages exist under `/Packages` path. We can add more..

Dependency injection related jobs exist in `DI` package. It has several protocols

> Check [Swinjector](https://github.com/EnesKaraosman/Swinjector) package for more detail about dependency injection. (Swinjector is created by me to demonstrate this PoC)

```swift
public protocol Injector {
    func registerFactory<T>(_ serviceType: T.Type, factory: @escaping () -> T)
    func registerSingleton<T>(_ serviceType: T.Type, instance: T)
    func registerLazySingleton<T>(_ serviceType: T.Type, factory: @escaping () -> T)

    func resolve<T>(_ serviceType: T.Type) -> T?
    func unregister<T>(_ serviceType: T.Type)
    func isRegistered<T>(_ serviceType: T.Type) -> Bool
    func reset()
}

public protocol ModuleInjection {
    func registerDependencies(injector: Injector)
}

public protocol FeatureResolver {
    var moduleInjection: ModuleInjection? { get }
}
```

Every package that we want it's dependencies to be registered to app, can implement `FeatureResolver` protocol. Check @main file to see how we register (dependency injection can be handled in a central place, dedicated class)

```swift
let getIt = DependencyInjector.shared
let injectionModules: [FeatureResolver] = [LoggerPackageResolver()]

for module in injectionModules {
    module.moduleInjection?.registerDependencies(injector: getIt)
}
```

This way;

- Any Package's dependencies can be registered into app.
- App's dependencies can be used in any package (if package has access to registered protocol/class)
- A package can use other package and it's dependencies (if package has access to registered protocol/class)

To demonstrate PoC, we've created `MonoRepoLogger` package. For more details see the implementation..

