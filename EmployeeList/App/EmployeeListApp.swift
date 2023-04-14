import SwiftUI

@main
struct EmployeeListApp: App {
    
    let store = Store<AppState, Action>(initial: AppState()) { state, action  in
        print("Reduce\t\t\t", action)
        state.reduce(action)
    }
    
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                NavigationView {
                    EmployeesViewConnector()
                }
            }
        }
    }
}
