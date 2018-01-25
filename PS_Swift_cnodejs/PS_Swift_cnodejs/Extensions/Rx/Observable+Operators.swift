import Foundation
import RxSwift
import RxCocoa

extension ControlEvent {

    public func subscribeNext(_ onNext: @escaping (E) -> Void) -> Disposable {
        return self.subscribe(onNext: onNext)
    }
}

extension Observable {
    
    /**
     Invokes an action for each Next event in the observable sequence, and propagates all observer messages through the result sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func doOnNext(_ onNext: @escaping (E) throws -> Void) -> Observable<E> {
        return self.do(onNext: onNext)
    }
    
    /**
     Invokes an action for the Error event in the observable sequence, and propagates all observer messages through the result sequence.
     
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func doOnError(_ onError: @escaping (Swift.Error) throws -> Void) -> Observable<E> {
        return self.do(onError: onError)
    }
    
    /**
     Invokes an action for the Completed event in the observable sequence, and propagates all observer messages through the result sequence.
     
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func doOnCompleted(_ onCompleted: @escaping () throws -> Void) -> Observable<E> {
        return self.do(onCompleted: onCompleted)
    }
    
    /**
     Subscribes an element handler to an observable sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeNext(_ onNext: @escaping (E) -> Void) -> Disposable {
        return self.subscribe(onNext: onNext)
    }
    
    /**
     Subscribes an error handler to an observable sequence.
     
     - parameter onError: Action to invoke upon errored termination of the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeError(_ onError: @escaping (Swift.Error) -> Void) -> Disposable {
        return self.subscribe(onError: onError)
    }
    
    /**
     Subscribes a completion handler to an observable sequence.
     
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func subscribeCompleted(_ onCompleted: @escaping () -> Void) -> Disposable {
        return self.subscribe(onCompleted: onCompleted)
    }
}


public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    
    /**
     Invokes an action for each Next event in the observable sequence, and propagates all observer messages through the result sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func doOnNext(_ onNext: @escaping (E) -> Void) -> Driver<E> {
        return self.do(onNext: onNext)
    }
    
    /**
     Invokes an action for the Completed event in the observable sequence, and propagates all observer messages through the result sequence.
     
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - returns: The source sequence with the side-effecting behavior applied.
     */
    public func doOnCompleted(_ onCompleted: @escaping () -> Void) -> Driver<E> {
        return self.do(onCompleted: onCompleted)
    }
    
    /**
     Subscribes an element handler to an observable sequence.
     
     - parameter onNext: Action to invoke for each element in the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func driveNext(_ onNext: @escaping (E) -> Void) -> Disposable {
        return self.drive(onNext: onNext)
    }
    
    /**
     Subscribes a completion handler to an observable sequence.
     
     - parameter onCompleted: Action to invoke upon graceful termination of the observable sequence.
     - returns: Subscription object used to unsubscribe from the observable sequence.
     */
    public func driveCompleted(_ onCompleted: @escaping () -> Void) -> Disposable {
        return self.drive(onCompleted: onCompleted)
    }
}


public extension ObserverType {
    
    /**
     Convenience method equivalent to `on(.Next(element: E))` and `on(.Completed)`
     
     - parameter element: Next element to send to observer(s)
     */
    public func onLast(_ element: E) {
        on(.next(element))
        on(.completed)
    }
}

protocol BooleanType {
    var boolValue: Bool { get }
}
extension Bool: BooleanType {
    var boolValue: Bool { return self }
}

// Maps true to false and vice versa
extension Observable where Element: BooleanType {
    func not() -> Observable<Bool> {
        return self.map { input in
            return !input.boolValue
        }
    }
}

extension Collection where Iterator.Element: ObservableType, Iterator.Element.E: BooleanType {
    
    func combineLatestAnd() -> Observable<Bool> {
        return Observable.combineLatest(self) { bools -> Bool in
            return bools.reduce(true, { (memo, element) in
                return memo && element.boolValue
            })
        }
    }
    
    func combineLatestOr() -> Observable<Bool> {
        return Observable.combineLatest(self) { bools in
            bools.reduce(false, { (memo, element) in
                return memo || element.boolValue
            })
        }
    }
}


public extension ObservableConvertibleType {
    
    public func lag() -> Observable<(previous: E?, current: E)> {
        return asObservable().scan((previous: nil as E?, current: nil as E?)) { ($0.current, current: $1) }
            .filter { $0.current != nil }
            .map { ($0, $1!) }
    }
    
    public func rewrite<T>(with value: T) -> Observable<T> {
        return asObservable().map { _ in value }
    }
    
    public func withLatestFrom<O: ObservableConvertibleType>(right second: O) -> Observable<(E, O.E)> {
        return asObservable().withLatestFrom(second) { ($0, $1) }
    }
    
    public func withLatestFrom<O: ObservableConvertibleType>(left second: O) -> Observable<(O.E, E)> {
        return asObservable().withLatestFrom(second) { ($1, $0) }
    }
    
    public func with<T, U>(_ value: T, resultSelector: @escaping (E, T) -> U) -> Observable<U> {
        return asObservable().withLatestFrom(Observable.just(value), resultSelector: resultSelector)
    }
    
    public func with<T>(right value: T) -> Observable<(E, T)> {
        return asObservable().with(value) { ($0, $1) }
    }
    
    public func with<T>(left value: T) -> Observable<(T, E)> {
        return asObservable().with(value) { ($1, $0) }
    }
    
    public func nilOnError() -> Observable<E?> {
        return asObservable().map(Optional.init).catchErrorJustReturn(nil)
    }
    
    /// Similar to startWith, but does not resolve the value until it is subscribed to.
    public func startWithWhenSubscribed(source: () -> E) -> Observable<E> {
        return asObservable().map { value in { value } }.startWith(source).map { $0() }
    }
}


extension ObservableType {
    
    /**
     Add observer with `id` and print each emitted event.
     - parameter id: an identifier for the subscription.
     */
    func debug(_ id: String) -> Disposable {
        return subscribe { debugPrint("Subscription:", id, "Event:", $0) }
    }
    
    /**
     Dismiss errors and complete the sequence instead
     
     - returns: An observable sequence that never errors and completes when an error occurs in the underlying sequence
     */
    public func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
}

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    func debug(_ id: String) -> Disposable {
        return self.asObservable().debug(id)
    }
}

func void<T>(_: T) {
    return Void()
}

