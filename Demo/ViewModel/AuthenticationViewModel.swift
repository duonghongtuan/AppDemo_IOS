import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    @Published var realmSevice: RealmService
    @Published var showAlert = false
    let rest = RestManager()

  enum SignInState {
    case signedIn
    case signedOut
  }
  @Published var state: SignInState = .signedOut
    
    init(realmService: RealmService = RealmService()){
        
        self.realmSevice = realmService
        
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
            state = .signedIn
            realmSevice.addUser(user: User(value: ["userId": userID, "name": (user?.profile!.name)!, "email": (user?.profile!.email)!]))
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
        realmSevice.deleteUser()
        state = .signedOut
      } catch {
        print(error.localizedDescription)
      }
    }
    
    func login(userID: String, name: String, email: String){
        
        guard let url = URL(string: "https://demo-gamma-six.vercel.app/api/auth/info") else { return }
                rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
                rest.httpBodyParameters.add(value: email, forKey: "email")
                rest.httpBodyParameters.add(value: userID, forKey: "userId")
                rest.httpBodyParameters.add(value: name, forKey: "name")

                rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
                    guard let response = results.response else { return }
                    if response.httpStatusCode != 200 {
                        self.showAlert = true
                    }
                        
            }
    }

}
