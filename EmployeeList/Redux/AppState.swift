import Foundation

public struct AppState {
    public var addEmployeeFlow = AddEmployeeFlow()
    public var addEmployeeForm = AddEmployeeForm()
    public var allEmployees = AllEmployees()
    public var searchResults = SearchbarState()
    public var infoAlert = InfoAlert()
    
    public mutating func reduce(_ action: Action) {
        addEmployeeFlow.reduce(action)
        addEmployeeForm.reduce(action)
        allEmployees.reduce(action)
        searchResults.reduce(action)
        infoAlert.reduce(action)
        
        if case .didAddEmployee = action {
            addEmployeeForm = .init()
        }
    }
    
    public init() {}
}
