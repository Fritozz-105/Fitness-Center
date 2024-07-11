import GoogleGenerativeAI
import SwiftUI

struct AiView: View 
{
    let model = GenerativeModel(name: "gemini-pro", apiKey: API-Key)
    @State var input = ""
    @State var reply = ""
    @State var isLoading = false
    @FocusState var isFocused: Bool
    
    @State var chatHistory: [ChatMessage] = []

    
    var body: some View 
    {
        VStack
        {
            ContentHeaderView(title: "Chat with FitBot",
                              subtitle: "",
                              bar1: Color.pink)
        }
        .frame(width: UIScreen.main.bounds.width * 2, height: 100)
        
        VStack
        {
            ScrollView
            {
                VStack
                {
                    ForEach(chatHistory, id: \.id) { message in
                        textMessageFormat(content: message)
                    }
                }
            }
            
            HStack
            {
                TextField("What do you need help with?", text: $input, axis: .vertical)
                    .padding()
                    .focused($isFocused)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    .lineLimit(5)
                    .autocorrectionDisabled()
                if isLoading
                {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .indigo))
                        .padding(.leading, 3)
                }
                else
                {
                    Button {
                        isFocused = false
                        generateResponse()
                    } label: {
                        Text("Send")
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func textMessageFormat(content: ChatMessage) -> some View
    {
        HStack(alignment: .bottom, spacing: 10)
        {
            if content.sender == .me { Spacer() }
            if content.sender == .ai {
                Image("ai")
                    .resizable()
                    .background(.black)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.black, lineWidth: 2)
                    }
                    .frame(width: 40, height: 40, alignment: .center)
            }
            Text(content.message)
                .foregroundColor(content.sender == .me ? Color.white : Color.black)
                .padding()
                .background(content.sender == .me ? Color.blue : Color.gray.opacity(0.1))
                .cornerRadius(16)
            if content.sender == .ai { Spacer() }
        }
    }
    
    func generateResponse()
    {
        
        guard !input.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        isLoading = true
        
        reply = ""
        let userMessage = ChatMessage(id: UUID().uuidString, message: input, dateCreated: Date(), sender: .me)
        chatHistory.append(userMessage)
        
        Task
        {
            do {
                let result = try await model.generateContent(input)
                reply = result.text ?? "No response found"
                let aiMessage = ChatMessage(id: UUID().uuidString, message: reply, dateCreated: Date(), sender: .ai)
                chatHistory.append(aiMessage) 
                input = ""
            }
            catch {
                reply = "Something went wrong\n\(error.localizedDescription)"
                let aiMessage = ChatMessage(id: UUID().uuidString, message: reply, dateCreated: Date(), sender: .ai)
                chatHistory.append(aiMessage)
            }
            isLoading = false
        }
    }
}

#Preview
{
    AiView()
}
