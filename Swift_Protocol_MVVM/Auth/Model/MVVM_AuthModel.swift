//
//  MVVM_AuthModel.swift
//  Swift_Protocol_MVVM
//
//  Created by zrq on 2019/4/12.
//  Copyright © 2019年 com.baidu.www. All rights reserved.
//

import UIKit

class MVVM_AuthModel: AuthModel {
    func login(userName: String, password: String, completionHandler: @escaping (NSError?) -> ()) {
        DispatchQueue.global().async {
            var error: NSError? = nil
            if userName != "123456@126.com" || password != "123456"{
                error = NSError(domain: "V", code: 1, userInfo: [NSLocalizedDescriptionKey:"Invalid Email or Password"])
            }else{
                DispatchQueue.main.async {
                    let currentVC: UIViewController? = self.getVC(app: UIApplication.shared)
                    let success: MVVMCListViewController = MVVMCListViewController()
                    currentVC?.present(success, animated: true, completion: {
                        print("成功了")
                    })
                }
            }
            
        }
        
    }
    func getVC(app: UIApplication) -> UIViewController? {
        
        var window = app.keyWindow
        if window?.windowLevel != UIWindow.Level.normal  {
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if tmpWin.windowLevel == UIWindow.Level.normal{
                    window = tmpWin
                    break
                }
            }
            
        }
        var result = window?.rootViewController
        while ((result?.presentingViewController) != nil) {
            result = result?.presentingViewController
        }
        if result is UITabBarController {
            let tabBar = result as? UITabBarController
            result = tabBar?.selectedViewController
        }
        if result is UINavigationController {
            let nav = result as? UINavigationController
            result = nav?.topViewController
        }
        return result
    }
    
}
