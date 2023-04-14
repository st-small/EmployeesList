import SwiftUI

struct EmployeeRowConnector: Connector {
    let id: UUID
    
    func map(state: AppState, store: EnvironmentStore) -> some View {
        let employee = state.allEmployees.byId[id]!
        return EmployeeRow(
            alias: "\(employee.firstName) \(employee.lastName)",
            salary: "\(Int(employee.salary)) $",
            birtdate: employee.birthdate
        )
    }
}

struct EmployeeRow: View {
    
    // MARK: - Props
    let alias: String
    let salary: String
    let birtdate: Date
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(alias)
                
                Spacer()
                
                Text(salary)
            }
            
            HStack {
                Text(birtdate, style: .date)
                    .font(.caption)
                    .foregroundColor(.primary.opacity(0.7))
                
                Spacer()
            }
        }
    }
}

struct EmployeeRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeRow(
            alias: "John Swift",
            salary: "900 $",
            birtdate: .now)
            .previewLayout(.sizeThatFits)
    }
}
