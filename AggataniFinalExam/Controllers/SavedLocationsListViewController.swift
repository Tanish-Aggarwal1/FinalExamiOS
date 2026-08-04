//
//  SavedLocationsListViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit

class SavedLocationsListViewController: UITableViewController {

    private let cellReuseIdentifier = "LocationCell"
    private var locations: [SavedLocation] = []

    var onSelect: ((SavedLocation) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Locations"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadLocations()
    }

    private func reloadLocations() {
        locations = DatabaseManager.shared.fetchAll()
        tableView.reloadData()

        if let first = locations.first {
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
            onSelect?(first)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.isEmpty ? 1 : locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)

        guard !locations.isEmpty else {
            cell.textLabel?.text = "No saved locations yet"
            cell.detailTextLabel?.text = "Search for a place on the Map Search screen"
            cell.selectionStyle = .none
            return cell
        }

        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = "ID: \(location.id)"
        cell.selectionStyle = .default
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !locations.isEmpty else { return }
        onSelect?(locations[indexPath.row])
    }
}
