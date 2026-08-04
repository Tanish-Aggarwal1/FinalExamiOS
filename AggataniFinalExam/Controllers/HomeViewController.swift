//
//  HomeViewController.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction private func didTapMapSearch() {
        performSegue(withIdentifier: "ShowMapSearch", sender: self)
    }

    @IBAction private func didTapSavedLocations() {
        performSegue(withIdentifier: "ShowSavedLocations", sender: self)
    }
}
