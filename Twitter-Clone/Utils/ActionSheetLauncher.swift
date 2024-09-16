//
//  ActionSheetLauncher.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 9/13/24.
//

import UIKit

class ActionSheetLauncher: NSObject {
    
    private let rowHeight: CGFloat = 60
    private var tableHeight: CGFloat {
        return (3 * rowHeight) + 100
    }
    
    private let user: UserModel
//    private var window: UIWindow?
    
    //MARK: Lifecycle
    
    init(user: UserModel) {
        self.user = user
        super.init()
    }
    
    //MARK: Helpers
    
    func show() {
        //        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        
//        self.window = window
        
        window.addSubview(backgroundView)
        backgroundView.frame = window.frame
        
        window.addSubview(tableViewConfig)
        tableViewConfig.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: tableHeight)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 1
            self.tableViewConfig.frame.origin.y -= self.tableHeight
        }
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0
            self.tableViewConfig.frame.origin.y += 300
        } completion: { _ in
            self.backgroundView.removeFromSuperview()
            self.tableViewConfig.removeFromSuperview()
        }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var tableViewConfig: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: ActionSheetCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        
        let height: CGFloat = 50
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
        cancelButton.layer.cornerRadius = height / 2
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
}

extension ActionSheetLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
}

extension ActionSheetLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionSheetCell.reuseIdentifier, for: indexPath) as! ActionSheetCell
        
        return cell
    }
    
}
