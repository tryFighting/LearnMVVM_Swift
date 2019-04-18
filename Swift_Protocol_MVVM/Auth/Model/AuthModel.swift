//
//  AuthModel.swift
//  Swift_Protocol_MVVM
//
//  Created by zrq on 2019/4/12.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

import Foundation
protocol AuthModel {
   
    func login(userName: String, password: String,completionHandler: @escaping(_ error: NSError?) ->())
    
}
