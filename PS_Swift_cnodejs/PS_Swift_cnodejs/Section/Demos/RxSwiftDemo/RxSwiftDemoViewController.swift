//
//  RxSwiftDemoViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.

// 注意：原生实现需要设置代理和数据源，使用RXSwift不需要设置和实现代理数据源

import UIKit
import RxSwift
import RxCocoa

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//歌曲列表数据源
struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}

class RxSwiftDemoViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    //歌曲列表数据源
    let musicListViewModel = MusicListViewModel()
    
    // 负责对象的销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //将数据源数据绑定到tableView上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier:"cell")) { _, music, cell in
                cell.textLabel?.text = music.name
                cell.detailTextLabel?.text = music.singer
            }.disposed(by: disposeBag)

        //tableView点击响应
        tableView.rx.modelSelected(Music.self).subscribe(onNext: { music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
        
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension RxSwiftDemoViewController {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "思思"
//        return cell
//    }
}
