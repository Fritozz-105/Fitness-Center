import SwiftUI

struct FCButton: View {
    let message: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button 
        {
            action()
        } label: {
            ZStack
            {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(message)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    FCButton(message: "Example",
             background: Color.blue)
    {
        // Example Action
    }
}
