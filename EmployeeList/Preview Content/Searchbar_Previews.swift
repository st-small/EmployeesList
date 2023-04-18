import SwiftUI

struct Searchbar_Previews: PreviewProvider {
    static var previews: some View {
        Searchbar(
            query: .constant(""),
            cancel: nil
        )
    }
}
