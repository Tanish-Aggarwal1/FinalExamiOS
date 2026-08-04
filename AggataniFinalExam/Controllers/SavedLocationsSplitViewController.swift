//
//  SavedLocationsSplitViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit

class SavedLocationsSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .oneBesideSecondary
        preferredPrimaryColumnWidthFraction = 0.38

        let listVC = SavedLocationsListViewController()
        let detailVC = SavedLocationDetailViewController()
        listVC.onSelect = { [weak detailVC] location in
            detailVC?.configure(with: location)
        }
        listVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didTapClose)
        )

        let primaryNav = UINavigationController(rootViewController: listVC)
        let secondaryNav = UINavigationController(rootViewController: detailVC)
        viewControllers = [primaryNav, secondaryNav]
    }

    @objc private func didTapClose() {
        dismiss(animated: true)
    }
}
