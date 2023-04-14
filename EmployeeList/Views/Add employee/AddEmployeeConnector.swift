import SwiftUI

struct AddEmployeeConnector: Connector {
    
    func map(state: AppState, store: EnvironmentStore) -> some View {
        AddEmployeeView(
            firstName: Binding(
                get: { state.addEmployeeForm.firstName },
                set: store.bind(Action.updateFirstName)),
            lastName: Binding(
                get: { state.addEmployeeForm.lastName },
                set: store.bind(Action.updateLastName)),
            gender: Binding(
                get: { state.addEmployeeForm.isMale ? "male" : "female" },
                set: { store.dispatch(.updateGender($0 == "male")) }),
            birthday: Binding(
                get: { state.addEmployeeForm.birthdate },
                set: store.bind(Action.updateBirthdate)),
            salary: Binding(
                get: { state.addEmployeeForm.salary },
                set: store.bind(Action.updateSalary)),
            department: Binding(
                get: { state.addEmployeeForm.department },
                set: store.bind(Action.updateDepartment)),
            addEmployeeAction: state.addEmployeeForm.isFormValid
            ? .available(store.bind(Action.didAddEmployee(state.addEmployeeForm.employee)))
            : .unavailable,
            onCancel: store.bind({ Action.didTapShowAddEmployeeForm($0)})
        )
    }
}
