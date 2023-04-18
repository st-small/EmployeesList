import SwiftUI

struct EmployeesViewConnector: Connector {
    func map(state: AppState, store: EnvironmentStore) -> some View {
        let isSearch = state.searchResults.query.isNotEmpty
        let sections = isSearch ? [state.searchResults.filteredEmployees] : state.allEmployees.sections
        return EmployeesView(
            sections: sections,
            departmentTitle: state.infoAlert.department?.title ?? "",
            departmentDescription: state.allEmployees.sectionDescription(state.infoAlert.department?.title ?? ""),
            isSearchMode: isSearch,
            showAddEmployeeForm: Binding(
                get: { state.addEmployeeFlow == .loginForm },
                set: { store.dispatch(Action.didTapShowAddEmployeeForm($0)) }),
            showDepartmentInfo: Binding(
                get: { state.infoAlert.department != nil },
                set: { _ in store.dispatch(.hideInfoAlert) }),
            addEmployeeModal: { AddEmployeeConnector() },
            employeeRow: { EmployeeRowConnector(id: $0) },
            searchbar: { SearchbarConnector() },
            onShowDepartmentInfo: store.bind(Action.showInfoAlert)
        )
    }
}
