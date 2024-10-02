//
//  EditProfileController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 10/1/24.
//

import UIKit

class EditProfileController: UITableViewController {
    
    private let user: UserModel
    
    //MARK: Lifecycle
    
    init(user: UserModel) {
        self.user = user
        super.init(style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationBar()
        configTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        
    }
    
    //MARK: Helpers
    
    func configNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ThemeColor.twitterBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
//        navigationController?.navigationBar.barTintColor = ThemeColor.twitterBlue
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
        
        navigationItem.title = "Edit Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func configTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 180)
        tableView.tableFooterView = UIView()
    }
    
    private lazy var headerView: EditProfileHeaderView = {
        let view = EditProfileHeaderView(user: self.user)
        view.delegate = self
        return view
    }()
}

extension EditProfileController: EditProfileHeaderViewDelegate {
    func didTapChangeProfilePhoto() {

    }
}
