import SwiftUI

struct SearchbarConnector: Connector {
    func map(state: AppState, store: EnvironmentStore) -> some View {
        Searchbar(
            query: Binding(
                get: { state.searchResults.query },
                set: { store.dispatch(.updateSearchQuery($0, state.allEmployees.byId.map({ $0.value }))) }),
            cancel: state.searchResults.canClearSearch
            ? store.bind(.clearSearchQuery) : nil
        )
    }
}

struct Searchbar: View {
    
    // MARK: - Props
    @Binding var query: String
    
    // MARK: - Commands
    let cancel: Command?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $query)
                .textFieldStyle(.roundedBorder)
            
            if cancel != nil {
                Button(action: cancel!.callAsFunction) {
                    Text("Clear")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}
