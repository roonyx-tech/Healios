import UIKit
import RxSwift
import InputMask

private enum Constants {
    static let cornerRadius: CGFloat = 12
    static let borderWidth: CGFloat = 1
}

class RegularTextField: UITextField {
    
    public var textEdit: Observable<String> {
        textSubject
    }
    
    public var filled: Observable<Bool> {
        isFilledSubject
    }
    
    public var format = "[…]"
    
//    private let listener = MaskedTextFieldDelegate(primaryFormat: format)
    let isFilledSubject = PublishSubject<Bool>()
    let textSubject = PublishSubject<String>()

    var currentState: RegularTextFieldState  = .normal {
        didSet {
            switch currentState {
            case .error :
                backgroundColor = currentState.backgroundColor
                layer.borderColor = currentState.borderColor
            default:
                backgroundColor = currentState.backgroundColor
                layer.borderColor = currentState.borderColor
                textColor = currentState.textColor
                font = currentState.textFont
            }
        }
    }
    
    override var placeholder: String? {
        didSet {
            configurePlaceholder()
        }
    }
    
    private let placeholderColor: UIColor = .lightGray
    private let placeholderFont: UIFont = .regular14
    
    override var isEnabled: Bool {
        didSet {
            if !isEnabled {
                currentState = .disabled
            } else {
                currentState = .normal
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureDelegate()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 18,
            y: superRect.origin.y,
            width: superRect.width - 16,
            height: superRect.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 18,
            y: superRect.origin.y,
            width: superRect.width - 16,
            height: superRect.height
        )
    }
    
    private func configureView() {
        configurePlaceholder()
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.borderWidth = Constants.borderWidth
        currentState = .normal
        tintColor = .black
        currentState = .normal
        setActions()
    }
    
    func configureDelegate() {
        let listener = MaskedTextFieldDelegate(primaryFormat: format)
        delegate = listener
        listener.onMaskedTextChangedCallback = { [weak self] field, _, isFilled in
            guard let text = field.text else { return }
            self?.textSubject.onNext(text)
            self?.isFilledSubject.onNext(isFilled)
        }
    }
    
    private func configurePlaceholder() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [
                                                    NSAttributedString.Key.foregroundColor: placeholderColor,
                                                    NSAttributedString.Key.font: placeholderFont])
    }
    
    private func setActions() {
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    @objc
    private func editingDidBegin() {
        switch currentState {
        case .error:
            return layer.borderColor = UIColor.red.cgColor
        default:
            return layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @objc
    private func editingDidChanged() {
        switch currentState {
        case .error:
            return layer.borderColor = UIColor.red.cgColor
        default:
            return layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @objc
    private func editingDidEnd() {
        switch currentState {
        case .error:
            return layer.borderColor = UIColor.red.cgColor
        default:
            return layer.borderColor = UIColor.black.cgColor
        }
    }
}
