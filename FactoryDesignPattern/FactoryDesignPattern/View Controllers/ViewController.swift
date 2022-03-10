//
//  ViewController.swift
//  FactoryDesignPattern
//
//  Created by Nuno Oliveira on 06/03/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        ApiRequestsFactory.shared.getList(for: .mockData) { [weak self] result in
            switch result {
            case .success(let data):
                print(">>> Data \(data)")
            case .failure(let error):
                print(">>> Error \(error)")
            }
        }
    }
}

