//
//  MainViewController.swift
//  component-view
//
//  Created by Kirill Vasilyev on 18.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    func sensorControl(_ control: SensorView, didChangeParameter parameter: Parameter) {

    }
    
    
    lazy var sensorInfoControl: SensorView = {
        let control = SensorView()
        return control
    }()
    
    var sensorView = SensorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(sensorView)
    }
    
    private func setupConstraints() {
        sensorView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
    
    func sensorInfoControl(_ control: SensorView, didChangeParameter parameter: Parameter) {
        switch parameter {
        case .airQuality:
            print("Air Quality selected")
        case .uvIndex:
            print("Radioactivity selected")
        }
    }
}
