import SwiftData
import SwiftUI

struct ExercisesView: View 
{
    @Binding var currentDate: Date
    @Query private var exercises: [Exercise]
    
    init(currentDate: Binding<Date>)
    {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Exercise>
        {
            return $0.creationDate >= startDate && $0.creationDate < endDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Exercise.creationDate, order: .forward)
        ]
        
        self._exercises = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 35)
        {
            ForEach(exercises) { exercise in
                ExerciseList(exercise: exercise)
                    .background(alignment: .leading) {
                        if exercises.last?.id != exercise.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -35)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
        .overlay
        {
            if exercises.isEmpty
            {
                Text("No workouts entered.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 200)
            }
        }
    }
}

#Preview 
{
    WorkoutView()
}
