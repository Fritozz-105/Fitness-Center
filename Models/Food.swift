import SwiftData
import SwiftUI

@Model
class Food: Identifiable
{
    var id: UUID
    var creationDate: Date
    var name: String
    var calories: String
    var protein: String
    var carbs: String
    var fats: String
    var tint: String
    
    init(id: UUID = .init(), creationDate: Date = .init(), name: String, calories: String, protein: String, carbs: String, fats: String, tint: String)
    {
        self.id = id
        self.creationDate = creationDate
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
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

