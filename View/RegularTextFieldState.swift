import UIKit

enum RegularTextFieldState {
    case error
    case success
    case selected
    case normal
    case disabled
    
    var backgroundColor: UIColor {
        switch self {
        case .error:
            return .white
        case .disabled:
            return UIColor.black.withAlphaComponent(0.4)
        default:
            return .white
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .error:
            return UIColor.red.cgColor
        case .success:
            return UIColor.black.cgColor
        default:
            return UIColor.purple.cgColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .disabled:
            return .lightGray
        default:
            return .black
        }
    }
    
    var textFont: UIFont {
        return .systemFont(ofSize: 13)
    }
}
