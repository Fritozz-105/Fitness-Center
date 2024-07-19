import SwiftUI
import Charts

struct WeighinGraphView: View
 {
    var weights: [Weight]
    
    private var weightValues: [Double] 
    {
        weights.compactMap { Double($0.weight) }
    }
    
    private var minWeight: Double 
    {
        weightValues.min() ?? 0.0
    }
    
    private var maxWeight: Double 
    {
        weightValues.max() ?? 1.0
    }
    
    private var yAxisValues: [Double] {
        if (weights.count == 1)
        {
            let low = floor(minWeight) - 1.0
            let high = ceil(maxWeight) + 1.0
            let step = ((high - low) / 4)
            return stride(from: low, through: high, by: step).map { $0 }
        }
        else
        {
            let low = floor(minWeight)
            let high = ceil(maxWeight)
            let step = ((high - low) / 4)
            return stride(from: low, through: high, by: step).map { $0 }
        }
    }
    
    private var xAxisValues: [Date] 
    {
        guard let firstDate = weights.first?.creationDate else {
             return []
        }
        var dates: [Date] = []
        let calendar = Calendar.current
        for i in 0..<7
        {
            if let date = calendar.date(byAdding: .day, value: i, to: calendar.startOfDay(for: firstDate)) 
            {
                dates.append(date)
            }
        }
        return dates
    }
    
    private func startOfDay(for date: Date) -> Date 
    {
        return Calendar.current.startOfDay(for: date)
    }
    
    var body: some View 
    {
        VStack 
        {
            if weights.isEmpty 
            {
                Text("No data available")
                    .foregroundColor(.gray)
                    .padding()
            }
            else 
            {
                Chart 
                {
                    ForEach(weights) { weight in
                        LineMark(
                            x: .value("Date", startOfDay(for: weight.creationDate)),
                            y: .value("Weight", Double(weight.weight) ?? 0.0)
                        )
                    }
                }
                .chartYAxis 
                {
                    AxisMarks(values: yAxisValues) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(centered: true)
                    }
                }
                .chartXAxis 
                {
                    AxisMarks(values: xAxisValues) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.day().month(), centered: true)
                    }
                }
                .chartYScale(domain: (floor(minWeight) - 0.25)...(ceil(maxWeight) + 0.25))
                .padding([.leading, .trailing], 15)
                .frame(height: 300)
            }
        }
        .frame(height: 300)
    }
}

#Preview 
{
    WeightTrackView()
}
