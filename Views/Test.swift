import SwiftUI

struct Test: View 
{
    var body: some View 
    {
        ContentHeaderView(title: "Profile",
                          subtitle: "",
                          bar1: Color.orange)
        .frame(width: UIScreen.main.bounds.width * 2, height: 100)
        
        
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
                        Text(User.testUser.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(User.testUser.email)
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
                        
                        Text("\(Date(timeIntervalSince1970: User.testUser.joinTime).formatted(date: .abbreviated, time: .shortened))")
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
                    //viewModel.signOut()
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

#Preview 
{
    Test()
}
