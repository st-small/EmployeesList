import Foundation

public struct AllEmployees {
    public var byId: [UUID: Employee] = [:]
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .didAddEmployee(employee):
            byId[employee.id] = employee
        case let .restoreStoredEmployees(employee):
            employee.forEach { byId[$0.id] = $0 }
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
        
        return departments
            .map { Department(title: $0.key, workers: $0.value.map({ $0.id })) }
            .sorted(by: { $0.title < $1.title })
    }
    
    public func sectionByTitle(_ title: String) -> Department? {
        sections.first(where: { $0.title.lowercased() == title.lowercased() })
    }
    
    public func sectionDescription(_ title: String) -> String {
        guard let section = sectionByTitle(title) else { return "" }
        
        let workers = byId.filter { section.workers.contains($0.key) }.map { $0.value }
        var resultString = "Department info:\nThere "
        
        if workers.count == 1 {
            resultString.append("is 1 worker\n")
        } else {
            resultString.append("are \(workers.count) workers\n")
        }
        
        
        let averageSalary = Int(workers.reduce(0) { $0 + $1.salary } / workers.count)
        resultString.append("Average salary is $\(averageSalary)")
        
        return resultString
    }
}
