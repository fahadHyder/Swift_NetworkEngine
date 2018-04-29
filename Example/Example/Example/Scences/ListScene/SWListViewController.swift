//
//  SWListViewController.swift
//
//  Created by fahad c h on 01/04/18.
//  Copyright © 2018 FahadHyder. All rights reserved.
//

import UIKit

class SWListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = SWListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getButtonPressed(sender: UIBarButtonItem) {
        viewModel.getStarWarsCharacters { [weak self](status) in
            if status {
                self?.tableView.reloadData()
            }
        }
    }

}

extension SWListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SWListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jdProfiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SWListCell", for: indexPath)
        let jdProfile = viewModel.jdProfiles?[indexPath.row]
        cell.textLabel?.text = jdProfile?.name;
        return cell
    }
}
