import SwiftUI

struct HeaderView: View 
{
    let title: String
    let subtitle: String
    let angle: Double
    let bar1: Color
    let bar2: Color
    let bar3: Color
    
    var body: some View
    {
        ZStack
        {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(bar3)
                .rotationEffect(Angle(degrees: -angle))
                .frame(height: 100)
                .offset(y: 175)
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(bar2)
                .rotationEffect(Angle(degrees: -angle))
                .frame(height: 100)
                .offset(y: 100)
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(bar1)
                .rotationEffect(Angle(degrees: -angle))
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
        .frame(width: UIScreen.main.bounds.width * 2, height: 300)
        .offset(y: -75)
        
        Spacer()
    }
}

#Preview
{
    HeaderView(title: "Example Title",
                    subtitle: "Example subtitle",
                    angle: -15,
                    bar1: Color.pink,
                    bar2: Color.blue,
                    bar3: Color.gray)
}
