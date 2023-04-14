import SwiftUI

struct StoreProvider<Content: View>: View {
    let store: Store<AppState, Action>
    let content: () -> Content
    
    var body: some View {
        content().environmentObject(EnvironmentStore(store: store))
    }
}
