import SwiftUI

struct MainCenterView: View
{
    @EnvironmentObject var viewModel: AuthenticatorViewModel
    @EnvironmentObject var manager: HealthAccessor
    @State var isLoading = true
    
    var body: some View
    {
        Group
        {
            if isLoading
            {
                OpeningAppView()
            }
            else if viewModel.userSession != nil
            {
                TabView
                {
                    OptionSelectionView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                }
            }
            else
            {
                LoginView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false // Set isLoading to false
            }
        }
    }
}

#Preview 
{
    MainCenterView()
}
