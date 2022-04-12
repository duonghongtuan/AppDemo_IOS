//
//  ApiService.swift
//  Demo
//
//  Created by Nhung Nguyen on 07/04/2022.
//

import Foundation
import Alamofire

class ApiService{
    private let url: String = "https://demo-gamma-six.vercel.app/api/"
    var apiQuestion : ApiQuestion
    
    init(){
        apiQuestion = ApiQuestion(url: url)
    }
}

