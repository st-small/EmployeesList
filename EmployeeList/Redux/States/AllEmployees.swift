import Foundation

public struct AllEmployees {
    public var byId: [UUID: Employee] = [:]
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .didAddEmployee(employee):
            byId[employee.id] = employee
        default:
            break
        }
    }
    
    public var sections: [Department] {
        let all = byId.map { $0.value }
        let departments = all.reduce([String: [Employee]]()) { (dict, employee) -> [String: [Employee]] in
            var dictionary = dict
            let department = employee.department.lowercased()

            if let employeesArray = dictionary[department] {
                var updatedArray = employeesArray
                updatedArray.append(employee)
                dictionary[department] = updatedArray
            } else {
                dictionary[department] = [employee]
            }
            
            return dictionary
        }
        
        return departments.map { Department(title: $0.key, workers: $0.value.map({ $0.id })) }
    }
}

public struct Department: Identifiable {
    public let id = UUID()
    public let title: String
    public let workers: [UUID]
}
