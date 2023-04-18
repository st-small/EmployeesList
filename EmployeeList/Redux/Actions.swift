import Foundation

public enum Action {
    case updateFirstName(String)
    case updateLastName(String)
    case updateGender(Bool)
    case updateBirthdate(Date)
    case updateSalary(Int)
    case updateDepartment(String)
    
    case didAddEmployee(Employee)
    case didTapShowAddEmployeeForm(Bool)
    
    case restoreStoredEmployees([Employee])
    
    case updateSearchQuery(String, [Employee])
    case clearSearchQuery
    
    case showInfoAlert(Department)
    case hideInfoAlert
}
