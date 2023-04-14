import SwiftUI

struct EmployeesViewConnector: Connector {
    func map(state: AppState, store: EnvironmentStore) -> some View {
        EmployeesView(
            sections: state.allEmployees.sections,
            showAddEmployeeForm: Binding(
                get: { state.addEmployeeFlow == .loginForm },
                set: store.bind(Action.didTapShowAddEmployeeForm)),
            addEmployeeModal: { AddEmployeeConnector() },
            employeeRow: { EmployeeRowConnector(id: $0) }
        )
    }
}

struct EmployeesView<Modal: View, EmployeeRow: View>: View {
    
    // MARK: - Props
    let sections: [Department]
    @Binding var showAddEmployeeForm: Bool
    
    let addEmployeeModal: () -> Modal
    let employeeRow: (UUID) -> EmployeeRow
    
    var body: some View {
        ZStack {
            Text("Employees list is empty")
                .foregroundColor(Color.black.opacity(sections.isEmpty ? 1 : 0))
            
            List(sections) { section in
                Section {
                    ForEach(section.workers, id: \.self) { workerId in
                        employeeRow(workerId)
                    }
                } header: {
                    HStack {
                        Text(section.title)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "info.circle")
                                .font(.body)
                        }
                    }
                    .foregroundColor(Color.primary.opacity(0.5))
                }
            }
            .listStyle(.automatic)
            .opacity(sections.isEmpty ? 0 : 1)
        }
            .toolbar {
                Button {
                    showAddEmployeeForm.toggle()
                } label: {
                    Text("Add employee")
                        .foregroundColor(Color.primary)
                }
            }
            .sheet(isPresented: $showAddEmployeeForm) {
                addEmployeeModal()
            }
            .navigationTitle("Employees list")
    }
}

struct EmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView(
            sections: [
                Department(title: "Department first", workers: [UUID(), UUID(), UUID(), UUID()]),
                Department(title: "Department second", workers: [UUID(), UUID(), UUID(), UUID()])
            ],
            showAddEmployeeForm: .constant(false),
            addEmployeeModal: { AddEmployeeView_Previews.previews },
            employeeRow: { _ in EmployeeRow_Previews.previews }
        )
    }
}
