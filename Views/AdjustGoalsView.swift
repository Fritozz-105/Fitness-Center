import SwiftUI

struct AdjustGoalsView: View 
{
    @EnvironmentObject var viewModel: AuthenticatorViewModel
    @EnvironmentObject var manager: HealthAccessor
    @Environment(\.dismiss) var dismiss
    @State var newStepGoal = ""
    @State var newCalorieGoal = ""
    
    var body: some View
    {
        VStack
        {
            VStack
            {
                ContentHeaderView(title: "Adjust Goals",
                                  subtitle: "",
                                  bar1: Color.pink)
                .frame(width: UIScreen.main.bounds.width * 2, height: 100)
            }
            .padding(.bottom, 15)
            
            Text("Adjust your daily step and calorie goals here.")
                .fontWeight(.semibold)
                .font(.footnote)
                .padding(.bottom, 50)
            
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("New Step Goal")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Steps", text: $newStepGoal)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    .keyboardType(.numberPad)
            })
            .padding(.top, 5)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("New Calorie Goal")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Calories", text: $newCalorieGoal)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color:. black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    .keyboardType(.numberPad)
            })
            .padding(.top, 5)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            
            Button {
                viewModel.updateGoals(steps: formatNumberString(newStepGoal) ?? "0", calories: formatNumberString(newCalorieGoal) ?? "0")
                manager.setStepGoal(stepGoal: formatNumberString(newStepGoal) ?? "0")
                manager.setCalorieGoal(calorieGoal: formatNumberString(newCalorieGoal) ?? "0")
                dismiss()
            } label: {
                HStack
                {
                    Text("Confirm Goals")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
        }
        .onAppear {
            if let user = viewModel.currentUser
            {
                newStepGoal = "\(user.stepGoal)"
                newCalorieGoal = "\(user.calorieGoal)"
            }
        }
    }
    
    func formatNumberString(_ numberString: String) -> String?
    {
        guard let number = Int(numberString) else {
            return nil
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))
    }
}

extension AdjustGoalsView: ValidateProtocol
{
    var formIsValid: Bool {
        return !newStepGoal.contains(",")
        && !newCalorieGoal.contains(",")
    }
}

#Preview 
{
    AdjustGoalsView()
}
