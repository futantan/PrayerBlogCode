//
//  SimpleValidationViewController.swift
//  RxSwiftDemo
//
//  Created by luckytantanfu on 5/3/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let minimalUsernameLength = 5
let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    @IBOutlet weak var doSomethingButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        // 创建 Observable 表示 username 是否合法（不少于5个字符）
        let usernameValid = usernameTextField.rx_text
            .debug("aaa")
            .map { $0.characters.count >= minimalUsernameLength }
            .shareReplay(1)
        
        // 创建 Observable 表示 passwordValid 是否合法（不少于5个字符）
        let passwordValid = passwordTextField.rx_text
            .map { $0.characters.count >= minimalUsernameLength }
        
        // 将 usernameValid 绑定到 usernameValidLabel 的 hidden 属性
        usernameValid
            .bindTo(usernameValidLabel.rx_hidden)
            .addDisposableTo(disposeBag)

        // 将 usernameValid 绑定到 passwordTextField 的 enabled 属性
        usernameValid
            .bindTo(passwordTextField.rx_enabled)
            .addDisposableTo(disposeBag)
        
        // 将 passwordValid 绑定到 passwordValidLabel 的 hidden 属性
        passwordValid
            .bindTo(passwordValidLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        // 由 usernameValid 和 usernameValid 共同决定 doSomethingButton 的 enable 状态
//        Observable.combineLatest(usernameValid, usernameValid) { $0 && $1 }
//            .bindTo(doSomethingButton.rx_enabled)
//            .addDisposableTo(disposeBag)
        
        // button 的点击事件
        doSomethingButton.rx_tap
            .subscribeNext { [weak self] in self?.showAlert() }
            .addDisposableTo(disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
