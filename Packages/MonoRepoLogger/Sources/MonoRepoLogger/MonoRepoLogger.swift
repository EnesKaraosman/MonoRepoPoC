import DI

public protocol Logger {
    func d(_ args: String...) -> Void
    func e(_ args: String...) -> Void
    func i(_ args: String...) -> Void
}

internal class LoggerImpl: Logger {
    func d(_ args: String...) {
        debugPrint("Logger.d [🐛]: \(args)")
    }
    
    func e(_ args: String...) {
        debugPrint("Logger.e [💥]: \(args)")
    }
    
    func i(_ args: String...) {
        debugPrint("Logger.i [📢]: \(args)")
    }
}

public class LoggerPackageResolver: FeatureResolver {
    public init() {}
    
    public var moduleInjection: ModuleInjection? {
        LoggerModuleInjection()
    }
}

private class LoggerModuleInjection: ModuleInjection {
    func registerDependencies(injector: Injector) {
        injector.registerLazySingleton(Logger.self) {
            LoggerImpl()
        }
    }
}
