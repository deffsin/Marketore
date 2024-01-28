import SwiftUI

struct TabBar: View {
    @StateObject var marketViewModel = MarketViewModel()
    @StateObject var accountViewModel = AccountViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
    @State private var selectedTab: Tab = .market
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack {
            Color(appColor: .whiteColor)
                .ignoresSafeArea()
            
            ZStack {
                switch selectedTab {
                case .market:
                    MarketView(viewModel: marketViewModel)
                case .account:
                    AccountView(viewModel: accountViewModel)
                case .settings:
                    SettingsView(viewModel: settingsViewModel, showSignInView: .constant(false))
                }
                
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    TabBar(showSignInView: .constant(false))
}


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case market, account, settings
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .market:
            return "cart"
        case .account:
            return "person"
        case .settings:
            return "gear"
        }
    }
}
