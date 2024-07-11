import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol ValidateProtocol
{
    var formIsValid: Bool {
        get
    }
}

@MainActor
class AuthenticatorViewModel: ObservableObject
{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage = ""
    
    init()
    {
        self.userSession = Auth.auth().currentUser
        Task
        {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws
    {
        do
        {
            errorMessage = ""
            let loginResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = loginResult.user
            await fetchUser()
        }
        catch
        {
            errorMessage = "Incorrect Email or Password"
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws
    {
        do
        {
            errorMessage = ""
            guard !password.contains(" ") else {
                errorMessage = "Please make sure the password has no spaces"
                return
            }
            
            let createResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = createResult.user
            let user = User(id: createResult.user.uid,
                            name: fullname,
                            email: email,
                            password: password,
                            joinTime: Date().timeIntervalSince1970,
                            stepGoal: "10,000",
                            calorieGoal: "300")
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }
        catch
        {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func signOut()
    {
        do
        {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch
        {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async
    {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(userID).getDocument() else {
            return
        }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func updateGoals(steps: String, calories: String)
    {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let database = Firestore.firestore().collection("users").document(userID)
        database.updateData(["stepGoal": steps,
                             "calorieGoal": calories])
        currentUser?.stepGoal = steps
        currentUser?.calorieGoal = calories
    }
}
