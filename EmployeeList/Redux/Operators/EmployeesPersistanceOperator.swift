import Foundation

final class EmployessPersistanceOperator {
    let storeEmployees: CommandWith<[Employee]>
    let loadEmployees: () -> [Employee]?
    
    let store: Store<AppState, Action>
    
    private var lastProcessEmployees: [Employee]?
    
    var asObserver: Observer<AppState> {
        Observer(queue: .main) { state in
            self.observe(state)
            return .active
        }
    }
    
    private func observe(_ state: AppState) {
        process(state: state)
    }
    
    init(
        store: Store<AppState, Action>,
        storeEmployees: CommandWith<[Employee]>,
        loadEmployees: @escaping () -> [Employee]?
    ) {
        self.store = store
        self.storeEmployees = storeEmployees
        self.loadEmployees = loadEmployees
        
        if let storedEmployees = loadEmployees() {
            lastProcessEmployees = storedEmployees
            store.dispatch(.restoreStoredEmployees(storedEmployees))
        }
    }
    
    func process(state: AppState) {
        process(employees: state.allEmployees.byId.map { $0.value })
    }
    
    func process(employees: [Employee]) {
        guard employees != lastProcessEmployees else { return }
        lastProcessEmployees = employees
        
        storeEmployees(employees)
    }
}

final class PersistanceService {
    
    private let employeesFileName = "employees"
    
    init() {
        debugPrint("Persistance directory is \(String(describing: try? prepareFileUrl().debugDescription))")
    }
    
    func load<T: Decodable>() throws -> T? {
        debugPrint("Loading employees ...")
        let url = try prepareFileUrl()
        let data = try Data(contentsOf: url)
        let value = try JSONDecoder().decode(T.self, from: data)
        
        return value
    }
    
    func store<T: Encodable>(value: T) throws {
        debugPrint("Storing employees ...")
        let data = try JSONEncoder().encode(value)
        try data.write(to: prepareFileUrl())
    }
    
    private func prepareFileUrl() throws -> URL {
        let folderUrl = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        return folderUrl.appending(path: employeesFileName)
    }
}
