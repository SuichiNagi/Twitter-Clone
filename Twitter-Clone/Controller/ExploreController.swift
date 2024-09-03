//
//  ExploreController.swift
//  Twitter-Clone
//
//  Created by Aldrei Glenn Nuqui on 8/21/24.
//

import UIKit

class ExploreController: UITableViewController {
    
    private var users = [UserModel]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        fetchUsers()
    }
    
    //MARK: API
    
    func fetchUsers() {
        UserService.shared.fetchUsers { users in
            self.users = users
        }
    }
    
    //MARK: Helpers
    
    func setUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier, for: indexPath) as! UserCell
        
        
        let user = users[indexPath.row]
        cell.set(user: user)
        
        return cell
    }
}
