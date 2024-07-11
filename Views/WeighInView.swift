import SwiftData
import SwiftUI

struct WeighInView: View 
{
    @Binding var currentDate: Date
    @Query private var weighinObj: [Weight]
    
    init(currentDate: Binding<Date>)
    {
        self._currentDate = currentDate
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate.wrappedValue))!
        let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
        let predicate = #Predicate<Weight> {
            return $0.creationDate >= startOfWeek && $0.creationDate < endOfWeek
        }
        
        let sortDescriptor = [
            SortDescriptor(\Weight.creationDate, order: .forward)
        ]
        
        self._weighinObj = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View
    {
        VStack(spacing: 15)
        {
            WeighinGraphView(weights: weighinObj)
            
            HStack(spacing: 10)
            {
                Text("Mean Weight:")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                Text("\(calculateMean(), specifier: "%.2f")lbs")
                    .font(.callout)

                Text("Median Weight:")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
                Text("\(calculateMedian(), specifier: "%.2f")lbs")
                    .font(.callout)
            }
            .padding([.leading, .trailing], 15)
            .hSpacing(.leading)
        }
        
        VStack(alignment: .leading, spacing: 35)
        {
            let todayWeighin = weighinObj.filter { Calendar.current.isDate($0.creationDate, inSameDayAs: currentDate) }
            ForEach(todayWeighin) { weight in
                WeightBlock(weight: weight)
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
        .overlay
        {
            let todayWeighin = weighinObj.filter { Calendar.current.isDate($0.creationDate, inSameDayAs: currentDate) }
            if todayWeighin.isEmpty
            {
                Text("No weigh in today.")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 200)
            }
        }
    }
    
    private var weightValues: [Double]
    {
        weighinObj.compactMap { Double($0.weight) }
    }
    
    private func calculateMean() -> Double
    {
        let totalWeight = weightValues.reduce(into: 0) { $0 += $1 }
        return weightValues.isEmpty ? 0 : totalWeight / Double(weightValues.count)
    }
    
    private func calculateMedian() -> Double
    {
        let sortedWeights = weightValues.map { $0 }.sorted()
        guard !sortedWeights.isEmpty else {
            return 0.0
        }

        let middleIndex = sortedWeights.count / 2
        if sortedWeights.count % 2 == 0
        {
            return (sortedWeights[middleIndex - 1] + sortedWeights[middleIndex]) / 2
        }
        else
        {
            return sortedWeights[middleIndex]
        }
    }
}

#Preview 
{
    WeightTrackView()
}
