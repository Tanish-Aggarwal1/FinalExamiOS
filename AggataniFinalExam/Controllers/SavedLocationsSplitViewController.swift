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
        title = "Saved Locations"
        preferredDisplayMode = .oneBesideSecondary
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
