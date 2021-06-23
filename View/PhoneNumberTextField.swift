import InputMask
import UIKit
import RxSwift

private enum Constants {
    static let textMask = "[000][000][00][00]"
    static let prefixText = "+7"
    static let prefixSpacing: CGFloat = 4
    static let dividerWidth: CGFloat = 0
    static let placeholder = ""
}

final class PhoneNumberTextField: RegularTextField {
    
    var phoneNumberText: String {
        guard let fieldText = text else { return "" }
        let text = CaretString(string: fieldText, caretPosition: fieldText.endIndex, caretGravity: .forward(autocomplete: false))
        let extractedValue =
            listener.primaryMask.apply(toText: text).extractedValue
        return extractedValue
    }

    var phoneTextObservable: Observable<String> {
        return phoneTextSubject
    }
    
   private var phoneTextSubject: PublishSubject<String> = .init()
    
    var isFilled: Observable<Bool> {
        filledSubject
    }
    
    override var isEnabled: Bool {
        didSet {
            prefixLabel.textColor = currentState.textColor
        }
    }

    private let listener = MaskedTextFieldDelegate(primaryFormat: Constants.textMask)
    private let filledSubject = PublishSubject<Bool>()
    private let prefixLabel = UILabel()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func setValue(phone: String) {
        listener.put(text: phone, into: self)
    }
    
    private func configureView() {
        setupInitialLayout()
        configureDelegate()
        configureTextStyle()
        configureColor()
    }
    
    private func setupInitialLayout() {
        addSubview(prefixLabel)
        addSubview(dividerView)
    }
    
    private func configureColor() {
        textColor = UIColor.black
        prefixLabel.textColor = UIColor.black
        dividerView.backgroundColor = UIColor.black
    }
    
    private func configureTextStyle() {
        returnKeyType = .next
        keyboardType = .numberPad
        prefixLabel.font = .systemFont(ofSize: 13)
        font = .systemFont(ofSize: 13)
        placeholder = Constants.placeholder
        prefixLabel.text = Constants.prefixText
    }
    
    override func configureDelegate() {
        delegate = listener
        listener.onMaskedTextChangedCallback = { [weak self] _, phoneText, isFilled in
            self?.filledSubject.onNext(isFilled)
            self?.phoneTextSubject.onNext(phoneText)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.textRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 3,
            y: superRect.origin.y,
            width: frame.width - superRect.origin.x - prefixLabel.intrinsicContentSize.width
                - Constants.dividerWidth - Constants.prefixSpacing,
            height: superRect.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let superRect = super.editingRect(forBounds: bounds)
        return CGRect(
            x: superRect.origin.x + 3,
            y: superRect.origin.y,
            width: frame.width - superRect.origin.x - prefixLabel.intrinsicContentSize.width -
                Constants.dividerWidth - Constants.prefixSpacing,
            height: superRect.height
        )
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect)
        updateInputFrame(forText: rect)
    }
    
    private func updateInputFrame(forText rect: CGRect) {
        let leadingSpace = min( Constants.prefixSpacing, frame.width - prefixLabel.intrinsicContentSize.width - 4)
//        dividerView.center.y = rect.height / 2
//        dividerView.frame.origin.x = leadingSpace + prefixLabel.intrinsicContentSize.width + Constants.prefixSpacing
//        dividerView.frame.size.height = prefixLabel.intrinsicContentSize.height
//        dividerView.frame.size.width = Constants.dividerWidth
        prefixLabel.center.y = rect.height / 2
        prefixLabel.frame.origin.x = leadingSpace
        prefixLabel.frame.size = prefixLabel.intrinsicContentSize
    }
}
