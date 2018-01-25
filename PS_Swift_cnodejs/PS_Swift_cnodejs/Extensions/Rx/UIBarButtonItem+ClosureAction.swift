import UIKit
import RxSwift
import RxCocoa

/// Extension of UIBarButtonItem, that adds option to use closure instead of target and selector
extension UIBarButtonItem {

    public convenience init(image: UIImage?, style: UIBarButtonItemStyle = .plain, action: (() -> Void)? = nil) {
        self.init(image: image, style: style, target: nil, action: nil)
        
        register(action: action)
    }

    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle,
                            action: (() -> Void)? = nil) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)

        register(action: action)
    }

    public convenience init(title: String?, style: UIBarButtonItemStyle = .plain, action: (() -> Void)? = nil) {
        self.init(title: title, style: style, target: nil, action: nil)

        register(action: action)
    }

    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, action: (() -> Void)? = nil) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)

        register(action: action)
    }

    private func register(action: (() -> Void)?) {
        if let action = action {
            _ = rx.tap.takeUntil(rx.deallocating).subscribe(onNext: action)
        }
    }
}
