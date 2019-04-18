//
//  MVVM_AuthViewModel.swift
//  Swift_Protocol_MVVM
//
//  Created by zrq on 2019/4/12.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

import UIKit

class MVVM_AuthViewModel: AuthViewModel {
    
    var model: AuthModel?
    fileprivate var emailIsValidFormat: Bool = false
    fileprivate var passwordIsValidFormat: Bool = false
   weak var viewDelegate: AuthViewModelDelegate?
    
    var userName: String = ""{
        didSet{
            if oldValue != userName {
                let oldCanSubmit = canSubmit
                emailIsValidFormat = validateEmail(userName)
                
                if canSubmit != oldCanSubmit{
                    viewDelegate?.canSubmit(self, status: canSubmit)
                }
            }
        }
    }
    
    var password: String = ""{
        didSet{
            if oldValue != password {
                let oldCanSubmit = canSubmit
                passwordIsValidFormat = validatePassword(password)
                if canSubmit != oldCanSubmit{
                    viewDelegate?.canSubmit(self, status: canSubmit)
                }
            }
        }
    }
    
    var canSubmit: Bool{
        return emailIsValidFormat && passwordIsValidFormat
    }
    
    func submit() {
        errorMessage = ""
        guard let dataModel = model, canSubmit else {
            errorMessage = NSLocalizedString("NOT_READY_TO_SUBMIT", comment: "")
            return
            
        }
        let modelCompletionHandler = {(error: NSError?) in
            DispatchQueue.main.async {
                guard let error = error else{
                    return
                }
                self.errorMessage = error.localizedDescription
            }
        }
        
        dataModel.login(userName: userName, password: password, completionHandler: modelCompletionHandler)
    }
    
   fileprivate(set) var errorMessage: String = ""{
    didSet{
        if oldValue != errorMessage {
            viewDelegate?.errorShow(self, message: errorMessage)
        }
    }
    }
    
    //验证email
    fileprivate func validateEmail(_ mail: String) -> Bool{
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: mail)
    }

    //验证密码
    fileprivate func validatePassword(_ password: String) -> Bool{
        let trimmedString = password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString.characters.count > 5
    }
    
}
