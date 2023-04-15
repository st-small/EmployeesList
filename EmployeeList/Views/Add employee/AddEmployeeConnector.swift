import SwiftUI

struct AddEmployeeConnector: Connector {
    
    func map(state: AppState, store: EnvironmentStore) -> some View {
        AddEmployeeView(
            firstName: Binding(
                get: { state.addEmployeeForm.firstName },
                set: { store.dispatch(.updateFirstName($0)) }),
            lastName: Binding(
                get: { state.addEmployeeForm.lastName },
                set: { store.dispatch(Action.updateLastName($0)) }),
            gender: Binding(
                get: { state.addEmployeeForm.isMale ? "male" : "female" },
                set: { store.dispatch(.updateGender($0 == "male")) }),
            birthday: Binding(
                get: { state.addEmployeeForm.birthdate },
                set: { store.dispatch(Action.updateBirthdate($0)) }),
            salary: Binding(
                get: { state.addEmployeeForm.salary },
                set: { store.dispatch(Action.updateSalary($0)) }),
            department: Binding(
                get: { state.addEmployeeForm.department },
                set: { store.dispatch(Action.updateDepartment($0)) }),
            addEmployeeAction: state.addEmployeeForm.isFormValid
            ? .available(store.bind(Action.didAddEmployee(state.addEmployeeForm.employee)))
            : .unavailable,
            onCancel: store.bind(Action.didTapShowAddEmployeeForm)
        )
    }
}
