import Foundation

public struct Employee: Equatable, Codable {
    let id: UUID
    let firstName: String
    let lastName: String
    let isMale: Bool
    let birthdate: Date
    let salary: Int
    let department: String
    
    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        isMale: Bool,
        birthdate: Date,
        salary: Int,
        department: String
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.isMale = isMale
        self.birthdate = birthdate
        self.salary = salary
        self.department = department
    }
}
