import KeychainAccess

private extension Keychain {
    static let `default` = Keychain()
}

@propertyWrapper
public struct KeychainEntry {
    public var wrappedValue: String? {
        get {
            try? Keychain.default.getString(key)
        }
        set {
            if let unwrappedValue = newValue {
                try? Keychain.default.set(unwrappedValue, key: key)
            } else {
                try? Keychain.default.remove(key)
            }
        }
    }

    private let key: String

    public init(_ key: String) {
        self.key = key
    }
}
