import SwiftUI

struct ExerciseList: View 
{
    @Bindable var exercise: Exercise
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
                Text(exercise.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                HStack(spacing: 25)
                {
                    Text("Sets: \(exercise.numberOfSets)")
                        .foregroundStyle(.black)
                    Text("Weight: \(exercise.weight)")
                        .foregroundStyle(.black)
                    Text("Reps: \(exercise.reps)")
                        .foregroundStyle(.black)
                }
            })
            .padding(15)
            .hSpacing(.leading)
            .background(exercise.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .offset(y: -8)
            .contentShape(.contextMenuPreview, .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .contextMenu
            {
                Button("Delete Exercise", role: .destructive)
                {
                    context.delete(exercise)
                    try? context.save()
                }
            }
        }
    }
}

#Preview 
{
    WorkoutView()
}
