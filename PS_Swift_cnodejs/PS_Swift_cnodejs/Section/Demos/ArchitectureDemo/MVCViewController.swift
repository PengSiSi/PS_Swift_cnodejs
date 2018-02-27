
//
//  MVCViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/2/7.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

struct Person {
    let firstName: String
    let lastName: String
}

class GreetingViewController: UIViewController {
    var person: Person!
    let btn = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 44)
        btn.backgroundColor = UIColor.orange
        self.btn.addTarget(self, action: #selector(didTapButton(button:)), for: .touchUpInside)
    }
    
    // 按钮点击
    @objc func didTapButton(button: UIButton) {
        print("firstName = \(self.person.firstName) lastname = \(self.person.lastName)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("firstName = \(self.person.firstName) lastname = \(self.person.lastName)")
    }
}

class MVCViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Person(firstName: "Si", lastName: "Peng")
        let view = GreetingViewController()
        view.person = model
        self.addChildViewController(view)
        self.view.addSubview(view.view)
    }
}
