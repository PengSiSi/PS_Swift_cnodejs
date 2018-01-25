import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {

    public var isEnableAlpha: Binder<Bool> {
        return Binder(base) { button, valid in
            button.isEnabled = valid
            button.alpha = valid ? 1.0 : 0.5
        }
    }
}
