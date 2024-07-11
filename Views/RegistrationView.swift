import SwiftUI

struct RegistrationView: View 
{
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthenticatorViewModel
    
    var body: some View
    {
        VStack
        {
            // Login Header Design
            HeaderView(title: "Register",
                       subtitle: "Start today!",
                       angle: -15,
                       bar1: Color.orange,
                       bar2: Color.red,
                       bar3: Color.green)
            
            Text(viewModel.errorMessage)
                .foregroundColor(Color(.systemRed))
            
            VStack(spacing: 24)
            {
                TextFieldView(input: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                
                TextFieldView(input: $fullname,
                              title: "Full Name",
                              placeholder: "Enter your name")
                .autocorrectionDisabled()
                
                TextFieldView(input: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecuredField: true)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                
                ZStack(alignment: .trailing)
                {
                    TextFieldView(input: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
                                  isSecuredField: true)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                    
                    if password.count > 5 && !confirmPassword.isEmpty
                    {
                        if password == confirmPassword
                        {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }
                        else
                        {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
                

            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task
                {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullname: fullname)
                }
            } label: {
                HStack
                {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemOrange))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3)
                {
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 16))
            }
        }
    }
}

extension RegistrationView: ValidateProtocol
{
    var formIsValid: Bool {
        return !email.trimmingCharacters(in: .whitespaces).isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.trimmingCharacters(in: .whitespaces).isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#Preview {
    RegistrationView()
}
