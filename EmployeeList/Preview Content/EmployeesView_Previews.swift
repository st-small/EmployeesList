import SwiftUI

struct EmployeesView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesView(
            sections: [
                Department(title: "Department first", workers: [UUID(), UUID(), UUID(), UUID()]),
                Department(title: "Department second", workers: [UUID(), UUID(), UUID(), UUID()])
            ],
            departmentTitle: "",
            departmentDescription: "",
            isSearchMode: false,
            showAddEmployeeForm: .constant(false),
            showDepartmentInfo: .constant(false),
            addEmployeeModal: { AddEmployeeView_Previews.previews },
            employeeRow: { _ in EmployeeRow_Previews.previews },
            searchbar: { Searchbar_Previews.previews },
            onShowDepartmentInfo: .init(action: { _ in })
        )
    }
}
