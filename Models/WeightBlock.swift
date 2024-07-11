import SwiftUI

struct WeightBlock: View
{
    @Bindable var weight: Weight
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
                Text("Weigh in for today:")
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                HStack(spacing: 25)
                {
                    Text("Weight: \(weight.weight)lbs")
                        .foregroundStyle(.black)
                }
            })
            .padding(15)
            .hSpacing(.leading)
            .background(weight.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .offset(y: -8)
            .contentShape(.contextMenuPreview, .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contextMenu
            {
                Button("Delete Weigh-in", role: .destructive)
                {
                    context.delete(weight)
                    try? context.save()
                }
            }
        }
    }
}

#Preview 
{
    WeightTrackView()
}
