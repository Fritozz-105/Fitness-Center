import SwiftUI

struct FoodList: View
{
    @Bindable var food: Food
    @Environment(\.modelContext) private var context
    
    var body: some View
    {
        HStack(alignment: .top, spacing: 15)
        {
            Circle()
                .fill(Color.orange)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(food.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                HStack(spacing: 25)
                {
                    Text("Calories: \(food.calories)")
                        .foregroundStyle(.black)
                }
                HStack(spacing: 50)
                {
                    Text("Protein: \(food.protein)g")
                        .foregroundStyle(.black)
                    Text("Carbs: \(food.carbs)g")
                        .foregroundStyle(.black)
                    Text("Fats: \(food.fats)g")
                        .foregroundStyle(.black)
                }
            })
            .padding(15)
            .hSpacing(.leading)
            .background(food.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .offset(y: -8)
            .contentShape(.contextMenuPreview, .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contextMenu
            {
                Button("Delete Food", role: .destructive)
                {
                    context.delete(food)
                    try? context.save()
                }
            }
        }
    }
}

#Preview
{
    FoodTrackView()
}
