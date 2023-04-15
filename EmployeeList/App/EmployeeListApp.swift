import SwiftUI

@main
struct EmployeeListApp: App {
    
    let store = Store<AppState, Action>(initial: AppState()) { state, action  in
        print("Reduce\t\t\t", action)
        state.reduce(action)
    }
    
    init() {
        connectPersistanceOperator()
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
    
    private func connectPersistanceOperator() {
        let service = PersistanceService()
        let persistanceOperator = EmployessPersistanceOperator(
            store: store,
            storeEmployees: CommandWith(action: { try? service.store(value: $0) }),
            loadEmployees: { try? service.load() })
        
        store.subscribe(observer: persistanceOperator.asObserver)
    }
}
