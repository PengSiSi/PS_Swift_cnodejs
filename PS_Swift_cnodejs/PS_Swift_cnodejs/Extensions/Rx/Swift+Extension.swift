import Foundation
import UIKit
import RxOptional

extension Optional {
    var hasValue: Bool {
        switch self {
        case .none: return false
        case .some(_): return true
        }
    }
}

// Extend the idea of occupiability to optionals. Specifically, optionals wrapping occupiable things.
extension Optional where Wrapped: Occupiable {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value.isEmpty
        }
    }
    
    var isNotNilNotEmpty: Bool {
        return !isNilOrEmpty
    }
}
