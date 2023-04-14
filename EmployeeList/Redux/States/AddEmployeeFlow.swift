public enum AddEmployeeFlow {
    case none
    case loginForm
    
    init() { self = .none }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .didTapShowAddEmployeeForm(show): self = show ? .loginForm : .none
        case .didAddEmployee: self = .none
        default: break
        }
    }
}
