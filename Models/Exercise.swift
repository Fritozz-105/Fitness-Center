import SwiftData
import SwiftUI

@Model
class Exercise: Identifiable
{
    var id: UUID
    var creationDate: Date
    var name: String
    var weight: String
    var numberOfSets: String
    var reps: String
    var tint: String
    
    init(id: UUID = .init(), creationDate: Date = .init(), name: String, weight: String, numberofSets: String, reps: String, tint: String)
    {
        self.id = id
        self.creationDate = creationDate
        self.name = name
        self.weight = weight
        self.numberOfSets = numberofSets
        self.reps = reps
        self.tint = tint
    }
    
    var tintColor: Color
    {
        switch tint
        {
            //[Color] = [.red, .orange, .yellow, .mint, .green, .brown, .pink, .blue, .purple, .indigo, .teal]
            case "red": return .red
            case "orange": return .orange
            case "yellow": return .yellow
            case "mint": return .mint
            case "green": return .green
            case "brown": return .brown
            case "pink": return .pink
            case "blue": return .blue
            case "purple": return .purple
            case "indigo": return .indigo
            case "teal": return .teal
            default: return .black
        }
    }
}
