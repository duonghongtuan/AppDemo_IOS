//
//  ApiQuestion.swift
//  Demo
//
//  Created by Nhung Nguyen on 07/04/2022.
//

import Foundation
import Alamofire
import Combine

class ApiQuestion{
    var url: String
    
    init(url: String){
        self.url = url
    }
    
    func addQuestion(question: Question){
        
        let url = "\(url)question/adds"

        AF.request(url ,method: .post, parameters: [question], encoder: JSONParameterEncoder.default)
            .responseData{ response in
            debugPrint(response)
                print(response.result)
            }
    }
    
    func getAllQuestions(userId: String, completion: @escaping ([Question]) -> Void){
        
        let url = "\(url)question/get-by-user-id"
        let parameters: [String: String] = [
            "userId": userId
        ]
                    
        AF.request(url ,method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .response { response in
                debugPrint("Response: \(response)")
                let decoder = JSONDecoder()
                guard let data = try? decoder.decode([Question].self, from: response.data!) else { return }
                print("Thanh cong")
                completion(data)
            }
    }
}

struct NetworkError: Error {
  let initialError: AFError
    let backendError: BackendError?
}
struct BackendError: Codable, Error {
    var status: String
    var message: String
}
struct ListQuestions: Codable {
    var questions: [Question]
}
