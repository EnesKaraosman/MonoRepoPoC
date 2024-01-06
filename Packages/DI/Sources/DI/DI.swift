import Swinjector

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

public class DependencyInjector: Injector {
    private let getIt = GetIt.I

    private init() {}

    public static let shared = DependencyInjector()

    public func registerFactory<T>(_ serviceType: T.Type, factory: @escaping () -> T) {
        getIt.registerFactory(serviceType, factory: factory)
    }

    public func registerSingleton<T>(_ serviceType: T.Type, instance: T) {
        getIt.registerSingleton(serviceType, instance: instance)
    }

    public func registerLazySingleton<T>(_ serviceType: T.Type, factory: @escaping () -> T) {
        getIt.registerLazySingleton(serviceType, factory: factory)
    }

    public func resolve<T>(_ serviceType: T.Type) -> T? {
        getIt.resolve(serviceType)
    }

    public func unregister<T>(_ serviceType: T.Type) {
        getIt.unregister(serviceType)
    }

    public func isRegistered<T>(_ serviceType: T.Type) -> Bool {
        getIt.isRegistered(serviceType)
    }

    public func reset() {
        getIt.reset()
    }
    
    public func callAsFunction<T>(_ serviceType: T.Type) -> T? {
        resolve(serviceType)
    }
}
