//
//  ViewController.swift
//  Shoppee
//
//  Created by Mạnh Hoàng Xuân on 05/08/2022.
//

import UIKit
import RevenueCat

class ViewController: UIViewController {
    private var packages: [Package] = []
    private var stacks: UIStackView = UIStackView(frame: .zero)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initViews()
        
        Purchases.shared.getOfferings { offerings, error in
            if let offering = offerings?.current {
                for package in offering.availablePackages {
                    print("Product: \(package.storeProduct.localizedTitle), price: \(package.localizedPriceString)")
                    self.packages.append(package)
                }
                
                for index in 0..<self.packages.count {
                    let package = self.packages[index]
                    let button = UIButton(type: .system)
                    button.tag = index
                    button.setTitle("\(package.storeProduct.localizedTitle), price: \(package.localizedPriceString)", for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                    button.addTarget(self, action: #selector(self.makePurchase(_:)), for: .touchUpInside)
                    button.backgroundColor = .blue
                    button.layer.cornerRadius = 8.0
                    self.stacks.addArrangedSubview(button)
                }
                
                
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }

    func initViews() {
        view.addSubview(stacks)
        stacks.translatesAutoresizingMaskIntoConstraints = false
        stacks.distribution = .fillEqually
        stacks.axis = .vertical
        stacks.spacing = 10.0
        stacks.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stacks.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stacks.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc func makePurchase(_ sender: UIButton) {
        let index = sender.tag
        if self.packages.indices.contains(index) {
            let package = self.packages[index]
            if Purchases.canMakePayments() {
                Purchases.shared.purchase(package: package) { transaction, customerInfo, error, success in
                    
                }
            }
        }
    }
}

