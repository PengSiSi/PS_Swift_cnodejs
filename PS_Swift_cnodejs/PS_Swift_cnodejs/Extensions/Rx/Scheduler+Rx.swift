import Foundation
import RxSwift
import RxCocoa

public enum RAScheduler{

    case main
    case serial(DispatchQoS)
    case concurrent(DispatchQoS)
    case operation(OperationQueue)
    
    
    public func scheduler() -> ImmediateSchedulerType{
    
        switch self {
        case .main:
            return MainScheduler.instance
        case .serial(let QOS):
            return SerialDispatchQueueScheduler(qos: QOS)
        case .concurrent(let QOS):
            return ConcurrentDispatchQueueScheduler(qos: QOS)
        case .operation(let queue):
            return OperationQueueScheduler(operationQueue: queue)
        }
    }
}

extension ObservableType{

    public func observeOn(scheduler:RAScheduler) -> Observable<Self.E>{
        return observeOn(scheduler.scheduler())
    }
}
