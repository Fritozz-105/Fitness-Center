import SwiftUI

struct ProfileView: View 
{
    @EnvironmentObject var viewModel : AuthenticatorViewModel
    
    var body: some View
    {
        NavigationView
        {
            if let user = viewModel.currentUser
            {
                List
                {
                    Section
                    {
                        HStack
                        {
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.blue)
                                .frame(width: 75, height: 75)
                                .padding(5)
                            
                            VStack(alignment: .leading, spacing: 4)
                            {
                                Text(user.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .accentColor(.gray)
                            }
                        }
                    }
                    Section("General")
                    {
                        VStack {
                            HStack(spacing: 12)
                            {
                                Image(systemName: "clock")
                                    .font(.title)
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("Member Since:")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .hSpacing(.leading)
                                
                                Text("\(Date(timeIntervalSince1970: user.joinTime).formatted(date: .abbreviated, time: .shortened))")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .hSpacing(.leading)
                            }
                            NavigationLink
                            {
                                AdjustGoalsView()
                            } label: {
                                
                                Image(systemName: "gear")
                                    .font(.title)
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("Adjust Goals")
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                                    .hSpacing(.leading)
                                
                                Spacer()
                            }
                        }
                    }
                    Section("Account")
                    {
                        Button {
                            viewModel.signOut()
                        } label: {
                            HStack(spacing: 12)
                            {
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.title)
                                    .imageScale(.small)
                                    .foregroundColor(.red)
                                
                                Text("Sign Out")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .hSpacing(.leading)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview 
{
    ProfileView()
        .environmentObject(AuthenticatorViewModel())
}
