import SwiftUI

struct AddEmployeeView: View {
    
    // MARK: - Props
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var gender: String
    @Binding var birthday: Date
    @Binding var salary: Int
    @Binding var department: String
    
    let addEmployeeAction: AddAction
    
    // MARK: - Commands
    let onCancel: CommandWith<Bool>
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                Color.clear.ignoresSafeArea()
                
                VStack {
                    
                    Text("Add new employee")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    TextField("Fisrt name", text: $firstName)
                        .focused($focusedField, equals: .firstName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 30)
                    
                    TextField("Last name", text: $lastName)
                        .focused($focusedField, equals: .lastName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 30)
                    
                    Picker("", selection: $gender) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    
                    DatePicker(
                        "Date of birth:",
                        selection: $birthday,
                        in: closedRange,
                        displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.horizontal, 30)
                    
                    
                    VStack {
                        HStack {
                            Text("Employee's current salary:")
                            Spacer()
                        }
                        
                        TextField("", value: $salary, formatter: numberFormatter)
                            .focused($focusedField, equals: .salary)
                            .font(.title)
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    
                    TextField("Department", text: $department)
                        .focused($focusedField, equals: .department)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                }
                .onSubmit {
                    switch focusedField {
                    case .firstName:
                        focusedField = .lastName
                    case .lastName:
                        focusedField = .department
                    default:
                        break
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        onCancel(false)
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onAddEmployee) {
                        Text("Add employee")
                            .disabled(addEmployeeAction.isDisabled)
                    }
                }
            }
            .padding()
        }
    }
    
    /// Helper function to fix dates range
    /// Mean's potential employee younger 50 and older 18 years old
    private var closedRange: ClosedRange<Date> {
        guard let min = Calendar.current.date(byAdding: .year, value: -50, to: .now),
              let max = Calendar.current.date(byAdding: .year, value: -18, to: .now) else { return Date(timeIntervalSince1970: 0)...Date() }
        
        return min...max
    }
    
    /// Implement custom number formatter
    /// Simplify user's input
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter
    }
    
    private func onAddEmployee() {
        if case let .available(command) = addEmployeeAction {
            command()
        }
    }
    
    enum Field {
        case firstName, lastName, salary, department
    }
    
    enum AddAction {
        case available(Command)
        case unavailable
        
        var isDisabled: Bool {
            if case .available = self { return false }
            else { return true }
        }
    }
}
