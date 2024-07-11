import SwiftUI

struct ActivityCard: Identifiable
{
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}



struct DailyActivityCard: View
{
    @State var activity: ActivityCard
    
    var body: some View
    {
        ZStack
        {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack(spacing: 20)
            {
                HStack(alignment: .top)
                {
                    VStack(alignment: .leading, spacing: 5)
                    {
                        Text(activity.title)
                            .font(.system(size: 16))
                        Text(activity.subtitle)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(.green)
                }
                
                Text(activity.amount)
                    .font(.system(size: 24))
            }
            .padding()
        }
    }
}

#Preview 
{
    DailyActivityCard(activity: ActivityCard(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "5,242"))
}
