import SwiftUI
import SwiftData

struct AddWeightView: View
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query private var weighinObj: [Weight]
    @State private var weight: String = ""
    @State private var weightColor: String = "red"
    
    init() 
    {
        let currentDate = Date()
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: currentDate)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Weight> {
            return $0.creationDate >= startDate && $0.creationDate < endDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Weight.creationDate, order: .forward)
        ]
        
        self._weighinObj = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View
    {
        if !weighinObj.isEmpty
        {
            VStack(alignment: .leading, spacing: 15, content: {
                Button(action: { dismiss() },
                       label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .tint(.red)
                })
                .hSpacing(.leading)
                .padding(.top, 20)
                .padding(.leading, 15)
                
            Spacer()
            })
            VStack(spacing: 8, content: {
                Text("Please delete the current weight before adding another weight measurement")
                    .font(.caption)
                    .foregroundStyle(.gray)
            })
            .padding(.bottom, 100)
        }
        else
        {
            VStack(alignment: .leading, spacing: 15, content: {
                Button(action: { dismiss() },
                       label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .tint(.red)
                })
                .hSpacing(.leading)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Weight")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("lbs", text: $weight)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.decimalPad)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                })
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Block Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    let colors: [String] = ["red", "orange", "yellow", "mint", "green", "brown", "pink", "blue", "purple", "indigo", "teal"]
                    
                    HStack(spacing: 0)
                    {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(stringToColor(color))
                                .frame(width:30, height: 30)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(weightColor == color ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        weightColor = color
                                    }
                                }
                        }
                    }
                })
                .padding(.top, 5)
                
                Button(action: {
                    let newWeighin = Weight(weight: weight, tint: weightColor)
                    
                    do
                    {
                        context.insert(newWeighin)
                        try context.save()
                        dismiss()
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                    
                }, label: {
                    Text("Add Weight")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(stringToColor(weightColor), in: .rect(cornerRadius: 10))
                })
                .disabled(weight == "")
                .opacity(weight == "" ? 0.5 : 1)
            })
            .padding(15)
        }
    }
    
    func stringToColor(_ tint: String) -> Color
    {
        switch tint
        {
            //[Color] = [.red, .orange, .yellow, .mint, .green, .brown, .pink, .blue, .purple, .indigo, .teal]
            case "red": return .red
            case "orange": return .orange
            case "yellow": return .yellow
            case "mint": return .mint
            case "green": return .green
            case "brown": return .brown
            case "pink": return .pink
            case "blue": return .blue
            case "purple": return .purple
            case "indigo": return .indigo
            case "teal": return .teal
            default: return .black
        }
    }
}

#Preview {
    WeightTrackView()
}
