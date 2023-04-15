class Command {
    init(action: @escaping () -> ()) {
        self.action = action
    }
    
    private let action: () -> ()
    
    func callAsFunction() {
        action()
    }
}

class CommandWith<T> {
    init(action: @escaping (T) -> ()) {
        self.action = action
    }
    
    private let action: (T) -> ()
    
    func callAsFunction(_ value: T) {
        action(value)
    }
}
