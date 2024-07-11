import SwiftUI

struct LoginView: View 
{
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthenticatorViewModel
    
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                // Login Header Design
                HeaderView(title: "Fitness Center",
                           subtitle: "Improve Your Fitness", 
                           angle: -15,
                           bar1: Color.pink, 
                           bar2: Color.blue,
                           bar3: Color.yellow)
                
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
                    
                    TextFieldView(input: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecuredField: true)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task
                    {
                        try await viewModel.signIn(withEmail: email, 
                                                   password: password)
                    }
                } label: {
                    HStack
                    {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
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
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3)
                    {
                        Text("New here?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 16))
                }
                
            }
        }
    }
}

extension LoginView: ValidateProtocol
{
    var formIsValid: Bool {
        return !email.trimmingCharacters(in: .whitespaces).isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.trimmingCharacters(in: .whitespaces).isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
