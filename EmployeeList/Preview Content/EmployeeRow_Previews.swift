import SwiftUI

struct EmployeeRow_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeRow(
            alias: "John Swift",
            salary: "900 $",
            birtdate: .now)
            .previewLayout(.sizeThatFits)
    }
}
