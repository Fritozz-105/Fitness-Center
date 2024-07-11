import SwiftUI

struct AddFoodView: View 
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var foodName: String = ""
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var carbs: String = ""
    @State private var fats: String = ""
    @State private var foodColor: String = "red"
    
    var body: some View
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
                Text("Exercise Name")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Food Name", text: $foodName)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            })
            .padding(.top, 5)
            
            HStack(spacing: 12)
            {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Calories")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Calories", text: $calories)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                        
                })
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Protein")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Grams", text: $protein)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                })
                .padding(.top, 5)
            }
            
            HStack(spacing: 12)
            {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Carbs")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Grams", text: $carbs)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                })
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Fats")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Grams", text: $fats)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                    
                })
                .padding(.top, 5)
            }
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
                                    .opacity(foodColor == color ? 1 : 0)
                            })
                            .hSpacing(.center)
                            .contentShape(.rect)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    foodColor = color
                                }
                            }
                    }
                }
            })
            .padding(.top, 5)
            
            Button(action: {
                let newFood = Food(name: foodName, calories: calories, protein: protein, carbs: carbs, fats: fats, tint: foodColor)
                
                do
                {
                    context.insert(newFood)
                    try context.save()
                    dismiss()
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }, label: {
                Text("Add Food")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(stringToColor(foodColor), in: .rect(cornerRadius: 10))
            })
            .disabled(foodName == "")
            .opacity(foodName == "" ? 0.5 : 1)
            .disabled(calories == "")
            .opacity(calories == "" ? 0.5 : 1)
            .disabled(protein == "")
            .opacity(protein == "" ? 0.5 : 1)
            .disabled(carbs == "")
            .opacity(carbs == "" ? 0.5 : 1)
            .disabled(fats == "")
            .opacity(fats == "" ? 0.5 : 1)

        })
        .padding(15)
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

#Preview 
{
    AddFoodView()
        .vSpacing(.bottom)
}
