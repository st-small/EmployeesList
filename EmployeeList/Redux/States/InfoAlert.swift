public enum InfoAlert {
    case none
    case show(Department)
    
    init() {
        self = .none
    }
    
    var department: Department? {
        guard case .show(let department) = self else {
            return nil
        }

        return department
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .showInfoAlert(department):
            self = .show(department)
        case .hideInfoAlert:
            self = .init()
        default:
            break
        }
    }
}
