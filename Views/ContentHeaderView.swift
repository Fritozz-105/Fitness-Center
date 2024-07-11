import SwiftUI

struct ContentHeaderView: View
{
    let title: String
    let subtitle: String
    let bar1: Color

    
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(bar1)
                .offset(y: -75)
            
            VStack
            {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .frame(width: UIScreen.main.bounds.width * 2, height: 250)
        
        
    }
}

#Preview
{
    ContentHeaderView(title: "Example Title",
                      subtitle: "Example subtitle",
                      bar1: Color.pink)
}
