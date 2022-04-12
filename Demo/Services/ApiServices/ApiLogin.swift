//
//  ApiLogin.swift
//  Demo
//
//  Created by Nhung Nguyen on 12/04/2022.
//

import Foundation
import Alamofire
import Firebase
import GoogleSignIn

class ApiLogin: ObservableObject {
    @Published var showAlert = false
    let rest = RestManager()

    init(){
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
          GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
              authenticateUser(for: user, with: error)
          }
        }
    }
    
    func signIn() {
      // 1
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
      } else {
        // 2
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 3
        let configuration = GIDConfiguration(clientID: clientID)
        
        // 4
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // 5
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
          authenticateUser(for: user, with: error)
        }
      }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        
      // 1
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 2
      guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
      
      // 3
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            login(userID: userID, name: (user?.profile!.name)!, email: (user?.profile!.email)!)
        }
      }
    }
    
    func signOut() {
      // 1
      GIDSignIn.sharedInstance.signOut()
      
      do {
        // 2
        try Auth.auth().signOut()
      } catch {
        print(error.localizedDescription)
      }
    }
    
    func login(userID: String, name: String, email: String){
        
        guard let url = URL(string: "https://demo-gamma-six.vercel.app/api/auth/info") else { return }
                
                let parameters: [String: String] = [
                    "UserId": userID,
                    "name": name,
                    "email": email
                ]
                AF.request(url ,method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
                .response{ response in
                    debugPrint(response)
            }
    }

}
