import SwiftUI

struct OptionSelectionView: View 
{
    @EnvironmentObject var manager: HealthAccessor
    @EnvironmentObject var viewModel: AuthenticatorViewModel
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                ContentHeaderView(title: "Welcome!",
                                  subtitle: "Select what you would like to do",
                                  bar1: Color.pink)
                .frame(width: UIScreen.main.bounds.width * 2, height: 100)
                Spacer()
                
                VStack
                {
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2))
                    {
                        ForEach(manager.activities.sorted(by: { $0.value.id < $1.value.id}), id: \.key) { item in
                            DailyActivityCard(activity: item.value)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack
                    {
                        NavigationLink(destination: WorkoutView())
                        {
                            VStack
                            {
                                TileView("dumbbell.fill", "Track Workout")
                            }
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                        
                        NavigationLink(destination: FoodTrackView())
                        {
                            VStack
                            {
                                TileView("fork.knife", "Log Food")
                            }
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                    }
                    
                    HStack
                    {
                        NavigationLink(destination: AiView())
                        {
                            VStack
                            {
                                TileView("person.fill.questionmark", "Ask AI")
                            }
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                        
                        NavigationLink(destination: WeightTrackView())
                        {
                            VStack
                            {
                                TileView("scalemass.fill", "Track Weight")
                            }
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                    }
                    Spacer()
                }
            }
            .onAppear {
                manager.setStepGoal(stepGoal: viewModel.currentUser?.stepGoal ?? "0")
                manager.setCalorieGoal(calorieGoal: viewModel.currentUser?.calorieGoal ?? "0")
            }
        }
    }
    
    @ViewBuilder
    func TileView(_ image: String, _ text: String) -> some View
    {
        VStack
        {
            Image(systemName: image)
            Text(text)
                .font(.system(size: 20, weight: .semibold))
        }
        .foregroundColor(.white)
        .padding(30)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black)
                .shadow(color: .gray, radius: 3, x: 8, y: 8)
                .shadow(color: .pink, radius: 3, x: -8, y: -8)
                .frame(width: 160, height: 160)
        }
    }
}

#Preview 
{
    OptionSelectionView()
}
