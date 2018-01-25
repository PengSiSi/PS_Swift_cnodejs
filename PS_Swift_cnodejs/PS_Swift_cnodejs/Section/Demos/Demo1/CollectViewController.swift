//
//  CollectViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2017/12/21.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class CollectViewController: BaseViewController {

    // 性别类型
    private var sexType: Int = UserDefaults.standard.integer(forKey: String.sexTypeKey)
    
    // 切换性别按钮
    private lazy var sexTypeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(changeSex), for: .touchUpInside)
        return btn
    }()
    
    // collectionView
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        // 注册
        collectionView.register(cellType: BaseCollectionViewCell.self)
        collectionView.uHead = URefreshHeader { [weak self] in self?.loadData() }
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        createUI()
        configureUI()
        loadData()
        
    }
    
    // 设置界面
    func createUI() {
        let label = UILabel().then {
            $0.textAlignment = .center
            $0.textColor = .black
            $0.text = "Hello, World!"
        }
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        label.center = view.center
        self.view.addSubview(label)
    }
    
    func configureUI() {
        view.addSubview(collectionView)
        view.addSubview(sexTypeButton)
        collectionView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(100)
        }
        sexTypeButton.snp.makeConstraints{
            $0.width.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-20)
            $0.right.equalToSuperview()
        }
    }
    
    // 加载数据
    func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.uHead.endRefreshing()
            self.sexTypeButton.setImage(UIImage(named: self.sexType == 1 ? "gender_male" : "gender_female"),
                                         for: .normal)
        }
    }
    
    @objc func changeSex() {
        sexType = sexType == 0 ? 1 : 0;
        UserDefaults.standard.set(sexType, forKey: String.sexTypeKey)
        UserDefaults.standard.synchronize()
        loadData()
    }
}

extension CollectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 240
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       return CGSize(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BaseCollectionViewCell.self)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    // 将要开始拖拽   隐藏50，显示10
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            UIView.animate(withDuration: 0.5, animations: {
                self.sexTypeButton.transform = CGAffineTransform(translationX: 50, y: 0)
            })
        }
    }
    
    // 回到原始位置
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            UIView.animate(withDuration: 0.5, animations: {
                self.sexTypeButton.transform = CGAffineTransform.identity
            })
        }
    }
}
