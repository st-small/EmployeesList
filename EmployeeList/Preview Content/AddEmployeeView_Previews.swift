import SwiftUI

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView(
            firstName: .constant(""),
            lastName: .constant(""),
            gender: .constant("male"),
            birthday: .constant(Date()),
            salary: .constant(151515),
            department: .constant(""),
            addEmployeeAction: .unavailable,
            onCancel: .init(action: { _ in })
        )
    }
}
