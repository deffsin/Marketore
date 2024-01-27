import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("Hello!")
            }
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.authenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            AuthenticationView(showSignInView: $showSignInView)
        }
    }
}

#Preview {
    RootView()
}
