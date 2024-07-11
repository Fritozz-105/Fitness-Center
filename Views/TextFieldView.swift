import SwiftUI

struct TextFieldView: View
{
    @Binding var input: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 12)
        {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecuredField
            {
                SecureField(placeholder, text: $input)
                    .font(.system(size: 14))
            }
            else
            {
                TextField(placeholder, text: $input)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview
{
    TextFieldView(input: .constant(""), title: "Enter text", placeholder: "Placeholder Text")
}
