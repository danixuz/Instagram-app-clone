//
//  ViewModel.swift
//  appTest
//
//  Created by Daniel Spalek on 23/04/2022.
//

import Foundation
import Firebase

final class ViewModel: ObservableObject{
    @Published var userIsLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @Published var currentPage: Page = .home
    @Published var dailyStories: [Story] = [Story(username: "therock", date: "22/04/2022", length: 10, content: "f8sn3mt9vux"), Story(username: "thisisbillgates", date: "22/04/2022", length: 10, content: "4nf8x62br0v"), Story(username: "kevinhart4real", date: "22/04/2022", length: 10, content: "4nf8c7whn30"), Story(username: "jeffbezos", date: "22/04/2022", length: 10, content: "c78ch2jr9f"), Story(username: "daniel.splk", date: "22/04/2022", length: 10, content: "49fn37nd4"), Story(username: "user1", date: "22/04/2022", length: 10, content: "389tnc7sn39r")]
    @Published var users = [String: User]()
    init(){
        getData()
    }
    
//    func getData() {
//        //Get a refrence to the database
//        let db = Firestore.firestore()
//        //read the documents at a specific path
//        db.collectionGroup("users").getDocuments { snapshot, error in
//
//            // Check for errors
//            if error == nil{
//                // No errors
//                if let snapshot = snapshot{ // letting us use the same parameter name while making sure that it isn't nil
//
//                    DispatchQueue.main.async { //update the users property in the main thread
//                        // Get all documents and create users
//                        self.users = snapshot.documents.map { d in
//                            //create a User for each document returned
//                            return User(username: d["username"] as? String ?? "nil", email: d["email"] as? String ?? "", password: d["password"] as? String ?? "", name: d["name"] as? String ?? "", bio: d["bio"] as? String ?? "", followers: d["followers"] as? Int ?? 0, following: d["following"] as? Int ?? 0, postCount: d["postCount"] as? Int ?? 0)
//                        }
//                    }
//
//                }
//            }else{
//                // Handle the error
//            }
//        }
//    }
    func getData(){
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collectionGroup("users")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let username = data["username"] as? String ?? "nil"
                    let name = data["name"] as? String ?? "nil"
                    let password = data["password"] as? String ?? "nil"
                    let postCount = data["postCount"] as? Int ?? 0
                    let following = data["following"] as? Int ?? 0
                    let followers = data["followers"] as? Int ?? 0
                    let email = data["email"] as? String ?? "nil"
                    let bio = data["bio"] as? String ?? "nil"
                    
                    let user = User(username: username, email: email, password: password, name: name, bio: bio, followers: followers, following: following, postCount: postCount)
                    
                    self.users[username] = user
                    print("user added")
                    
                }
            }
        }
    }
    
    static func addToDailyStories() -> Void{
        //MARK: function should receive a story and add it to the daily stories array
    }
}
