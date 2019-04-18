//
//  AuthViewModel.swift
//  Swift_Protocol_MVVM
//
//  Created by zrq on 2019/4/12.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

import Foundation
protocol AuthViewModelDelegate: class {
    func canSubmit(_ viewModel: AuthViewModel,status: Bool)
    func errorShow(_ viewModel: AuthViewModel,message: String)
}
protocol AuthViewModel {
    var model: AuthModel?{get set}
    var viewDelegate: AuthViewModelDelegate?{get set}
    
    //userName and password
    var userName: String{get set}
    var password: String{get set}
    
    //Submit
    var canSubmit: Bool {get}
    func submit()
    
    var errorMessage: String{get}
    
    
    
}
