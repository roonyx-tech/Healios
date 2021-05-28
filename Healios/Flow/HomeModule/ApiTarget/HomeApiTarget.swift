enum HomeApiTarget: ApiTarget {
    case posts
    case users
    case comments
    
    var version: ApiVersion {
        return .custom("")
    }
    
    var servicePath: String {
        switch self {
        case .comments:
            return "comments"
        case .posts:
            return "posts"
        case .users:
            return "users"
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var stubData: Any {
        return [:]
    }
}
