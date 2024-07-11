import Foundation
import SwiftUI

extension View
{
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View
    {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View
    {
        self
            .frame(maxHeight:. infinity, alignment: alignment)
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool
    {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
}

extension Encodable
{
    func makeDictionary() -> [String: Any]
    {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        do
        {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

extension Date
{
    var isToday: Bool
    {
        return Calendar.current.isDateInToday(self)
    }
    
    struct Weekday: Identifiable
    {
        var id: UUID = .init()
        var date: Date
    }
    
    func format(_ format: String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getWeek(_ date: Date = .init()) -> [Weekday]
    {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        var week: [Weekday] = []
        let thisWeek = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard let startOfWeek = thisWeek?.start else {
            return []
        }
        
        (0..<7).forEach { index in if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) { 
            week.append(.init(date: weekDay)) }
        }
        
        return week
    }
    
    func createNextWeek() -> [Weekday]
    {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        
        return getWeek(nextDate)
    }
    
    func createPreviousWeek() -> [Weekday]
    {
        let calendar = Calendar.current
        let startOfCurrentDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfCurrentDate) else {
            return []
        }
        
        return getWeek(previousDate)
    }
    
    static func updateHour(_ value: Int) -> Date
    {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
