import Foundation
import HealthKit

extension Date
{
    static var startOfDay: Date
    {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double
{
    func formattedString() -> String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}

class HealthAccessor: ObservableObject
{
    let healthStore = HKHealthStore()
    @Published var activities: [String : ActivityCard] = [:]
    
    init()
    {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let healthTypes: Set = [steps, calories]
        
        Task
        {
            do
            {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                //getSteps()
                //getCalories()
            }
            catch
            {
                print("Error fetching health data.")
            }
        }
    }
    
    func getSteps()
    {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay,end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching step count.")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = ActivityCard(id: 0, title: "Todays Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaysSteps"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func getCalories()
    {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay,end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories burned.")
                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = ActivityCard(id: 1, title: "Todays Calories", subtitle: "Goal: 500", image: "flame", amount: caloriesBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todaysCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func setStepGoal(stepGoal: String)
    {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay,end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching step count.")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = ActivityCard(id: 0, title: "Todays Steps", subtitle: "Goal: \(stepGoal)", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaysSteps"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func setCalorieGoal(calorieGoal: String)
    {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay,end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Error fetching calories burned.")
                return
            }
            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = ActivityCard(id: 1, title: "Todays Calories", subtitle: "Goal: \(calorieGoal)", image: "flame", amount: caloriesBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todaysCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
}
