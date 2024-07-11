import SwiftData
import SwiftUI

struct FoodLogView: View 
{
    @Binding var currentDate: Date
    @Query private var foodlog: [Food]
    
    init(currentDate: Binding<Date>)
    {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Food>
        {
            return $0.creationDate >= startDate && $0.creationDate < endDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Food.creationDate, order: .forward)
        ]
        
        self._foodlog = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View
    {
        VStack
        {
            Text("Nutrition Values for Today")
            
            HStack(spacing: 15)
            {
                Text("Calories: \(getNutrition()[0], specifier: "%.2f")")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                Text("Protein: \(getNutrition()[1], specifier: "%.2f")g")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
            }
            
            HStack(spacing: 15)
            {
                Text("Carbs: \(getNutrition()[2], specifier: "%.2f")g")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                Text("Fats: \(getNutrition()[3], specifier: "%.2f")g")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
            }
        }
        
        VStack(alignment: .leading, spacing: 35)
        {
            ForEach(foodlog) { food in
                FoodList(food: food)
                    .background(alignment: .leading) {
                        if foodlog.last?.id != food.id {
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
            if foodlog.isEmpty
            {
                Text("No foods entered.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 200)
            }
        }
    }
    
    private var caloriesValues: [Double]
    {
        foodlog.compactMap { Double($0.calories) }
    }
    
    private var proteinValues: [Double]
    {
        foodlog.compactMap { Double($0.protein) }
    }
    
    private var carbValues: [Double]
    {
        foodlog.compactMap { Double($0.carbs) }
    }
    
    private var fatValues: [Double]
    {
        foodlog.compactMap { Double($0.fats) }
    }
    
    private func getNutrition() -> [Double]
    {
        var nutritionValues: [Double] = [0.0, 0.0, 0.0, 0.0]
        nutritionValues[0] = caloriesValues.reduce(into: 0) { $0 += $1 }
        nutritionValues[1] = proteinValues.reduce(into: 0) { $0 += $1 }
        nutritionValues[2] = carbValues.reduce(into: 0) { $0 += $1 }
        nutritionValues[3] = fatValues.reduce(into: 0) { $0 += $1 }
        
        return nutritionValues
    }
}

#Preview 
{
    FoodTrackView()
}
