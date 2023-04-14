import Foundation

public struct AppState {
    public var addEmployeeFlow = AddEmployeeFlow()
    public var addEmployeeForm = AddEmployeeForm()
    public var allEmployees = AllEmployees()
    
    public mutating func reduce(_ action: Action) {
        addEmployeeFlow.reduce(action)
        addEmployeeForm.reduce(action)
        allEmployees.reduce(action)
        
        if case .didAddEmployee = action {
            addEmployeeForm = .init()
        }
    }
    
    public init() {}
}
