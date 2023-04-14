import Foundation

public struct AddEmployeeForm {
    public var firstName: String = ""
    public var lastName: String = ""
    public var isMale: Bool = true
    public var birthdate: Date = .now
    public var salary: Int = 0
    public var department: String = ""
    
    public var isFormValid: Bool {
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        salary != 0 &&
        department.isNotEmpty
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .updateFirstName(value):
            firstName = value
        case let .updateLastName(value):
            lastName = value
        case let .updateGender(value):
            isMale = value
        case let .updateBirthdate(value):
            birthdate = value
        case let .updateSalary(value):
            salary = value
        case let .updateDepartment(value):
            department = value
        default:
            break
        }
    }
    
    var employee: Employee {
        Employee(
            firstName: firstName,
            lastName: lastName,
            isMale: isMale,
            birthdate: birthdate,
            salary: salary,
            department: department
        )
    }
}
