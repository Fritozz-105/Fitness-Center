import Foundation

struct User: Identifiable, Codable
{
    let id: String
    let name: String
    let email: String
    let password: String
    let joinTime : TimeInterval
    var stepGoal: String
    var calorieGoal: String
}

extension User
{
    static var testUser = User(id: NSUUID().uuidString, name: "Zoochy Poochy", email: "testing@zz.com", password: "password1", joinTime: 1719974507.018312, stepGoal: "10,000", calorieGoal: "500")
}
