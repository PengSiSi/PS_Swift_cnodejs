//
//  NodeViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/12.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit

class NodeViewController: BaseViewController {

    // MARK: - UI
    private lazy var segmentedControl: UISegmentedControl = {
       let segment = UISegmentedControl(items: ["节点导航", "全部节点"])
        segment.tintColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentControlDidChangeHandle), for: .valueChanged)
        return segment
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumLineSpacing = 15
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NodeCell.self, forCellWithReuseIdentifier: NodeCell.description())
        collectionView.register(NodeHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NodeHeaderView.description())
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    private weak var allNodeViewController: AllNodeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupSubViews()
        setupContraints()
    }
    
    func setupSubViews() {
        navigationItem.titleView = segmentedControl
        
        let allNodeVC = AllNodeViewController()
        allNodeViewController = allNodeVC
        addChildViewController(allNodeVC)
    }
    
    func setupContraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension NodeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView: NodeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NodeHeaderView.description(), for: indexPath) as! NodeHeaderView
        headerView.title = "节点"
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NodeCell.description(), for: indexPath) as! NodeCell
        if indexPath.section == 0 {
            cell.node = "ndejdnjeke"
        } else {
            cell.node = "思思"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension NodeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var node: String!
        if indexPath.section == 0 {
            node = "ndejdnjeke"
        } else {
            node = "思思"
        }
        let w = node.toWidth(fontSize: UIFont.preferredFont(forTextStyle: .body).pointSize + 5)
        return CGSize(width: w, height: 30)
    }
}

extension NodeViewController {
    
    @objc func segmentControlDidChangeHandle() {
        if let allNodeVC = childViewControllers.first,
            !allNodeVC.isViewLoaded {
            view.addSubview(allNodeVC.view)
            allNodeVC.view.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                if #available(iOS 11.0, *) {
                    $0.top.bottom.equalTo(view.safeAreaInsets)
                } else {
                    $0.top.equalTo(self.topLayoutGuide.snp.bottom)
                    $0.bottom.equalTo(self.bottomLayoutGuide.snp.top)
                }
            }
        }
        if segmentedControl.selectedSegmentIndex == 0 {
            collectionView.fadeIn()
            allNodeViewController?.view.fadeOut()
        } else {
            collectionView.fadeOut()
            allNodeViewController?.view.fadeIn()
        }
    }
}
