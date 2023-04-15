import SwiftUI

struct EmployeesViewConnector: Connector {
    func map(state: AppState, store: EnvironmentStore) -> some View {
        let isSearch = state.searchResults.query.isNotEmpty
        let sections = isSearch ? [state.searchResults.filteredEmployees] : state.allEmployees.sections
        return EmployeesView(
            sections: sections,
            showAddEmployeeForm: Binding(
                get: { state.addEmployeeFlow == .loginForm },
                set: { store.dispatch(Action.didTapShowAddEmployeeForm($0)) }),
            addEmployeeModal: { AddEmployeeConnector() },
            employeeRow: { EmployeeRowConnector(id: $0) },
            searchbar: { SearchbarConnector() }
        )
    }
}

struct EmployeesView<Modal: View, EmployeeRow: View, Searchbar: View>: View {
    
    // MARK: - Props
    let sections: [Department]
    @Binding var showAddEmployeeForm: Bool
    
    let addEmployeeModal: () -> Modal
    let employeeRow: (UUID) -> EmployeeRow
    let searchbar: () -> Searchbar
    
    var body: some View {
        ZStack {
            Text("Employees list is empty")
                .foregroundColor(Color.black)
            
            List {
                
                searchbar()
                
                ForEach(sections) { section in
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
            }
            .listStyle(.grouped)
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
            employeeRow: { _ in EmployeeRow_Previews.previews },
            searchbar: { Searchbar_Previews.previews }
        )
    }
}
