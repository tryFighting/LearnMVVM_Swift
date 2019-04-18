//
//  ViewController.swift
//  Swift_Protocol_MVVM
//
//  Created by zrq on 2019/4/11.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    fileprivate var isLoad: Bool = false
    var viewModel:  AuthViewModel?{
        willSet{
            viewModel?.viewDelegate = nil
        }
        didSet{
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    fileprivate func refreshDisplay(){
        guard isLoad else{return}
        if let viewModel = viewModel {
            userName.text = viewModel.userName
            password.text = viewModel.password
            error.text = viewModel.errorMessage
            submit.isEnabled = viewModel.canSubmit
        }else{
            userName.text = ""
            password.text = ""
            error.text = ""
            submit.isEnabled = false
        }
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        title = "Login"
        isLoad = true
        
        userName.addTarget(self, action: #selector(emailFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        password.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        userName.addTarget(self, action: #selector(inputUserName(_:)), for: UIControlEvents.editingChanged)
//        password.addTarget(self, action: #selector(inputPassword(_:)), for: UIControlEvents.editingChanged)
        submit.addTarget(self, action: #selector(submitP), for: .touchUpInside)
        refreshDisplay()
        
    }

    @objc func submitP() {
        viewModel?.submit()
    }
    @objc func emailFieldDidChange(_ textField: UITextField)
    {
        if let text = textField.text {
            if text == "123456@126.com"{
                textField.resignFirstResponder()
            }
            viewModel?.userName = text
        }
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField)
    {
        
        if let text = textField.text {
            if text == "123456"{
                textField.resignFirstResponder()
            }
            viewModel?.password = text
        }
    }
}
extension ViewController : AuthViewModelDelegate
{
    func canSubmit(_ viewModel: AuthViewModel, status: Bool) {
        submit.isEnabled = status
    }
    
    func errorShow(_ viewModel: AuthViewModel, message: String) {
        error.text = message
    }
    
    
}
