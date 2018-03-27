//
//  SearchVC.swift
//  Aireport
//
//  Created by Wenba on 2018/3/27.
//  Copyright © 2018年 ZacJi. All rights reserved.
//

import UIKit

class SearchVC: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!

    var places = [Place]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.textLabel?.text = places[indexPath.row].station.name
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AirAPI.cityUid = places[indexPath.row].uid
        dismiss(animated: true, completion: nil)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        AirAPI.getCities(keyword: searchText) { (places) in
            self.places = places
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
