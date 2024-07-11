import Foundation

enum MessageSender
{
    case me
    case ai
}

struct ChatMessage
{
    let id: String
    let message: String
    let dateCreated: Date
    let sender: MessageSender
}

extension ChatMessage
{
    static let sampleMessages = [
    ChatMessage(id: UUID().uuidString, message: "Sample message from me", dateCreated: Date(), sender: .me),
    ChatMessage(id: UUID().uuidString, message: "Sample message from gemini", dateCreated: Date(), sender: .ai),
    ChatMessage(id: UUID().uuidString, message: "Sample message from me", dateCreated: Date(), sender: .me),
    ChatMessage(id: UUID().uuidString, message: "Sample message from gemini", dateCreated: Date(), sender: .ai)
    ]
}
