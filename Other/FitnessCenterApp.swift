import Firebase
import SwiftUI

@main
struct FitnessCenterApp: App 
{
    init()
    {
        FirebaseApp.configure()
    }
    
    @StateObject var viewModel = AuthenticatorViewModel()
    @StateObject var manager = HealthAccessor()
    
    var body: some Scene
    {
        WindowGroup
        {
            MainCenterView()
                .environmentObject(viewModel)
                .environmentObject(manager)
        }
        .modelContainer(for: [Exercise.self, Food.self, Weight.self])
    }
}

