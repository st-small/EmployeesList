import SwiftUI

struct EmployeesView<Modal: View, EmployeeRow: View, Searchbar: View>: View {
    
    // MARK: - Props
    let sections: [Department]
    let departmentTitle: String
    let departmentDescription: String
    let isSearchMode: Bool
    @Binding var showAddEmployeeForm: Bool
    @Binding var showDepartmentInfo: Bool
    
    let addEmployeeModal: () -> Modal
    let employeeRow: (UUID) -> EmployeeRow
    let searchbar: () -> Searchbar
    
    // MARK: - Commands
    let onShowDepartmentInfo: CommandWith<Department>
    
    var body: some View {
        ZStack {
            Text("Employees list is empty")
                .foregroundColor(Color.black)
            
            List {
                
                searchbar()
                
                ForEach(sections) { department in
                    Section {
                        ForEach(department.workers, id: \.self) { workerId in
                            employeeRow(workerId)
                        }
                    } header: {
                        if !department.workers.isEmpty {
                            HStack {
                                Text(department.title)
                                
                                Spacer()
                                
                                Button {
                                    onShowDepartmentInfo(department)
                                } label: {
                                    Image(systemName: "info.circle")
                                        .font(.body)
                                }
                            }
                            .foregroundColor(Color.primary.opacity(isSearchMode ? 0 : 0.5))
                        }
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
            .alert(
                Text(departmentTitle.uppercased()),
                isPresented: $showDepartmentInfo,
                actions: {
                    Button {
                        
                    } label: {
                        Text("OK")
                            .foregroundColor(.primary)
                    }

            }, message: {
                Text(departmentDescription)
            })
            .sheet(isPresented: $showAddEmployeeForm) {
                addEmployeeModal()
            }
            .navigationTitle("Employees list")
    }
}
