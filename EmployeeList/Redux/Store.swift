import Foundation

public final class Store<State, Action> {
    public typealias Reducer = (inout State, Action) -> ()
    private let queue = DispatchQueue(label: "Store queue", qos: .userInitiated)
    
    public private(set) var state: State
    private var observers: Set<Observer<State>> = []
    let reducer: Reducer
    
    public init(initial state: State, reducer: @escaping Reducer) {
        self.state = state
        self.reducer = reducer
    }
    
    public func dispatch(_ action: Action) {
        queue.async {
            self.reducer(&self.state, action)
            self.observers.forEach(self.notify)
        }
    }
    
    public func subscribe(observer: Observer<State>) {
        queue.async {
            self.observers.insert(observer)
            self.notify(observer)
        }
    }
    
    private func notify(_ observer: Observer<State>) {
        let status = observer.queue.sync {
            observer.observe(state)
        }
        
        if case .dead = status {
            observers.remove(observer)
        }
    }
}
