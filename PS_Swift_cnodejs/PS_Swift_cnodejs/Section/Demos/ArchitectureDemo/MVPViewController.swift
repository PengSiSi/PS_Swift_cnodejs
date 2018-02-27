
//
//  MVPViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/2/7.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

import UIKit
struct Person1 { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingView: class {
    func setGreeting(greeting: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person)
    func showGreeting()
}

class GreetingPresenter : GreetingViewPresenter {
    unowned let view: GreetingView
    let person: Person
    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = "Hello;" + " " + self.person.firstName + " " + self.person.lastName
        self.view.setGreeting(greeting: greeting)
    }
}
class Greeting1ViewController : UIViewController, GreetingView {
    var presenter: GreetingViewPresenter!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: #selector(didTapButton(button:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(button: UIButton) {
        presenter.showGreeting()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel.text = greeting
    }
    // layout code goes here
}

class MVPViewController: BaseViewController {

    let model1 = Person1(firstName: "aaa", lastName: "bbb")
    let view1 = Greeting1ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
