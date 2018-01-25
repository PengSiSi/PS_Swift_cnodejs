//
//  CommentInputViewController.swift
//  PS_Swift_cnodejs
//
//  Created by 思 彭 on 2018/1/15.
//  Copyright © 2018年 思 彭. All rights reserved.
//

import UIKit
import SnapKit
import MobileCoreServices

class CommentInputViewController: BaseViewController {

    private lazy var commentInputView: CommentInputView = {
        let view = CommentInputView(frame: .zero)
        view.isHidden = true
        view.backgroundColor = UIColor.lightGray
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var backTopBtn: UIButton = {
        let view = UIButton()
        view.setImage(#imageLiteral(resourceName: "backTop"), for: .normal)
        view.setImage(#imageLiteral(resourceName: "backTop"), for: .selected)
        view.sizeToFit()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4
        self.view.addSubview(view)
        view.addTarget(self, action: #selector(backTopAction(btn:)), for: .touchUpInside)
        view.isHidden = true
        // 长按手势
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        view.addGestureRecognizer(longTap)
        return view
    }()
    
    // 是否显示回复框
    public var showInputView: Bool?
    
    private var inputViewBottomConstranit: Constraint?
    private var inputViewHeightConstraint: Constraint?
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.lightGray
        tw.delegate = self
        tw.dataSource = self
        tw.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tw.keyboardDismissMode = .onDrag  // tableView拖动，加盘下移
        tw.keyboardDismissMode = .interactive  // 向下拖动键盘视图键盘下移
        return tw
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let view = UIImagePickerController()
        view.mediaTypes = [kUTTypeImage as String]
        view.sourceType = .photoLibrary
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "回复输入框Demo"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        commentInputView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(55)
            $0.left.right.equalToSuperview()
        }
        self.view.bringSubview(toFront: self.backTopBtn)
        backTopBtn.snp.makeConstraints {
            $0.right.bottom.equalTo(-30)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "...", style: .plain, target: self, action: #selector(shareAction))
        // 通知
        NotificationCenter.default.addObserver(self, selector: #selector(kbFrameChanged(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        commentInputView.sendHandle = { [weak self] in
            self?.replyComment()
        }
        commentInputView.uploadPictureHandle = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        commentInputView.updateHeightHandle = { [weak self] height in
            self?.inputViewHeightConstraint?.update(offset: height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let isShow = showInputView {
            if isShow == false {
                commentInputView.isHidden = true
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        commentInputView.textView.resignFirstResponder()
    }
}

extension CommentInputViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
//        cell.selectionStyle = .default
        cell.textLabel?.text = "思思"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            //            self.becomeFirstResponder()  这里先注释
            let qqItem = UIMenuItem(title: "QQ", action: #selector(mqq))
            let wechatItem = UIMenuItem(title: "wechat", action: #selector(wechat))
            self.becomeFirstResponder()
            let menuController = UIMenuController.shared
            menuController.menuItems = [qqItem, wechatItem]
            menuController.setTargetRect(cell.frame, in: cell.superview!)
            menuController.setMenuVisible(true, animated: true)
//            selectedText = cell.textLabel?.text
        }
    }
    
    // 解决点击cell menuViewController不显示
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension CommentInputViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        commentInputView.textView.resignFirstResponder()
        
        // ContentSize 大于 当前视图高度才显示， 滚动到底部/顶部按钮
        // 150 的偏差
        backTopBtn.isHidden = tableView.contentSize.height < (tableView.height + 150)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        if offsetY > 200 {
            self.commentInputView.backgroundColor = UIColor.white
            self.commentInputView.isHidden = false
        }
    }
}

extension CommentInputViewController {
    
    @objc private func mqq() {

    }
    
    @objc private func wechat() {
        
    }
    
    @objc private func backTopAction(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            // 滑到顶部
           self.tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.contentInset.top), animated: true)
        } else {
            // 滑到底部
            self.tableView.scrollToBottom()
        }
    }
    
    // 长按
    @objc private func longPressAction() {
        let alertController = UIAlertController(title: "切换分页", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "上一页", style: .default, handler: { (alertAction) in
            print("上一页")
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func kbFrameChanged(_ notification : Notification){
        let info = notification.userInfo
        let kbRect = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let offsetY = kbRect.origin.y - UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: offsetY)
        }
    }
}

extension CommentInputViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        guard var image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        image = image.resized(by: 0.7)
        guard let data = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        let path = FileManager.document.appendingPathComponent("smfile.png")
        let error = FileManager.save(data, savePath: path)
        if let err = error {
          print(err)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            self.commentInputView.textView.becomeFirstResponder()
        }
    }
}

extension CommentInputViewController {
    
    @objc private func replyComment() {
        
    }
}

// MARK: - 分享
extension CommentInputViewController {
    
    @objc private func shareAction() {
        view.endEditing(true)
        let item1 = ShareItem(icon: #imageLiteral(resourceName: "image"), title: "copyLink", type: .copyLink)
        let item2 = ShareItem(icon: #imageLiteral(resourceName: "image"), title: "safari", type: .safari)
        let section1 = [item1, item2]
        let section2 = [item2, item1,item1,item1,item1]
        let shareView = ShareSheetView(sections: [section1, section2])
        shareView.present()
        shareView.shareSheetDidSelectedHandle = { [weak self] type in
            self?.shareSheetDidSelectedHandle(type)
        }
    }
    
    private func shareSheetDidSelectedHandle(_ type: ShareItemType) {
        switch type {
            // 复制链接
        case .copyLink:
            copyLink()
            // sari中打开
        case .safari:
            openSafariHandle()
        default:
            break
        }
    }
    
    private func copyLink() {
        
    }
    
     private func openSafariHandle() {
        
    }
}
