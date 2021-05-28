import UIKit
import RxSwift
import RxCocoa

public final class ProgressView: UIView {
    
    private let progressWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = .alert
        return window
    }()
    
    private let animationView = UIActivityIndicatorView()
    
    public enum Status {
        case loading
        case success
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var instance = ProgressView()
    
    public func show(_ status: Status = .loading, animated: Bool = true) {
        progressWindow.makeKeyAndVisible()
        progressWindow.addSubview(self)
        frame = progressWindow.bounds
        
        switch status {
        case .loading:
            addSubview(animationView)
            animationView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            animationView.style = .medium
            animationView.layer.cornerRadius = 8
            animationView.startAnimating()
            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    animationView.widthAnchor.constraint(equalToConstant: Constants.animationSize),
                    animationView.heightAnchor.constraint(equalToConstant: Constants.animationSize)
                ]
            )
        case .success:
            animationView.stopAnimating()
        }
        
        if animated {
            alpha = 0.0
            
            UIView.animate(withDuration: 0) {
                self.alpha = 1.0
            }
        }
    }
    
    private var isAnimating = false
    
    public func hide(animated: Bool = false) {
        if !animated {
            hideNotAnimated()
            return
        }
        
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.alpha = 0.0
            },
            completion: { _ in
                self.hideNotAnimated()
            }
        )
    }
    
    public func hideIfNotAnimating() {
        if isAnimating { return }
        
        hide(animated: true)
    }
    
    private func hideNotAnimated() {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.removeFromSuperview()
        self.progressWindow.isHidden = true
    }
}

private extension ProgressView {
    
    enum Constants {
        static let animationSize: CGFloat = 70
    }
}

public extension Reactive where Base: ProgressView {
    
    var loading: Binder<Bool> {
        return Binder(base) { target, loading in
            if loading {
                target.show()
            } else {
                target.hide()
            }
        }
    }
}
