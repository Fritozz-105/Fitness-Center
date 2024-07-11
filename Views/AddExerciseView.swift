import SwiftUI

struct AddExerciseView: View 
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var exerciseName: String = ""
    @State private var numberOfSets: String = ""
    @State private var weight: String = ""
    @State private var reps: String = ""
    @State private var exerciseColor: String = "red"
    
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
                
                TextField("Exercise Name", text: $exerciseName)
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
                    Text("Number of Sets")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("# Sets", text: $numberOfSets)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                        
                })
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Weight")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("lbs", text: $weight)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numberPad)
                })
                .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Reps")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("12, 12, 12, ...", text: $reps)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                        .keyboardType(.numbersAndPunctuation)
                    
                })
                .padding(.top, 5)
            }
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Exercise Color")
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
                                    .opacity(exerciseColor == color ? 1 : 0)
                            })
                            .hSpacing(.center)
                            .contentShape(.rect)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    exerciseColor = color
                                }
                            }
                    }
                }
            })
            .padding(.top, 5)
            
            Button(action: { 
                let newExercise = Exercise(name: exerciseName, weight: weight, numberofSets: numberOfSets, reps: reps, tint: exerciseColor)
                
                do
                {
                    context.insert(newExercise)
                    try context.save()
                    dismiss()
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }, label: {
                Text("Add Exercise")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(stringToColor(exerciseColor), in: .rect(cornerRadius: 10))
            })
            .disabled(exerciseName == "")
            .opacity(exerciseName == "" ? 0.5 : 1)
            .disabled(numberOfSets == "")
            .opacity(numberOfSets == "" ? 0.5 : 1)
            .disabled(weight == "")
            .opacity(weight == "" ? 0.5 : 1)
            .disabled(reps == "")
            .opacity(reps == "" ? 0.5 : 1)

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
    AddExerciseView()
        .vSpacing(.bottom)
}
