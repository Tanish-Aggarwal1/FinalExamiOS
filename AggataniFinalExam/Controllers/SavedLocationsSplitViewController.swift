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

        guard let primaryNav = viewControllers.first as? UINavigationController,
              let listVC = primaryNav.topViewController as? SavedLocationsListViewController,
              let secondaryNav = viewControllers.last as? UINavigationController,
              let detailVC = secondaryNav.topViewController as? SavedLocationDetailViewController else {
            return
        }

        listVC.onSelect = { [weak detailVC] location in
            detailVC?.configure(with: location)
        }
    }
}
