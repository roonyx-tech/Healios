import Foundation

public class InMemoryCache {
    private var cachedData: [ObjectIdentifier: Any?] = [:]
    
    public func set<T>(data: T) {
        cachedData[ObjectIdentifier(T.self)] = data
    }
    
    public func get<T>() -> T? {
        cachedData[ObjectIdentifier(T.self)] as? T
    }
    
    public init() {}
}

