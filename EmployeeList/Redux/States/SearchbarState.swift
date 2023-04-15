public struct SearchbarState {
    public var query: String = ""
    public var dataSource: [Employee] = []
    
    var canClearSearch: Bool {
        query.count > 0
    }
    
    var filteredEmployees: Department {
        let workers = dataSource.filter { $0.firstName.lowercased().contains(query.lowercased()) || $0.lastName.lowercased().contains(query.lowercased()) }.map { $0.id }
        
        return Department(title: "Search results", workers: workers)
    }
    
    mutating func reduce(_ action: Action) {
        switch action {
        case let .updateSearchQuery(value, employees):
            self = SearchbarState()
            query = value
            dataSource = employees
        case .clearSearchQuery:
            self = SearchbarState()
        default:
            break
        }
    }
}
