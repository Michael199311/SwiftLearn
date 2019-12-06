//
//  ViewController.swift
//  SwiftLearn
//
//  Created by mgc000005751 on 12/3/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nameVaild = nameTextField.rx.text.orEmpty
            .map{ $0.count > 5 }
            .share(replay: 1)
        
        nameVaild.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        
        let passwordVaild = passwordTextField.rx.text.orEmpty
            .map{ $0.count > 5 }
            .share(replay: 1)
        
        let allVaild = Observable.combineLatest(nameVaild, passwordVaild){ $0 && $1 }.share(replay: 1)
        
        allVaild.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe( onNext: {
            self.showLoginSuccessAlert()
        }).disposed(by: disposeBag)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func showLoginSuccessAlert() {
        let ac = UIAlertController(title: "Debug", message: title, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true, completion: nil)
        let alertView = UIAlertController(title: "登录成功", message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "确定", style: .default, handler: {action in 
            print("登录成功")
        }
        ))
    }
    
    
}

