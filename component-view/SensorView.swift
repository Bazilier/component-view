//
//  SensorView.swift
//  component-view
//
//  Created by Kirill Vasilyev on 3.08.2023.
//

import UIKit
import SnapKit

// Перечисление для определения текущего параметра
enum Parameter {
    case airQuality
    case uvIndex
}

// Основной класс представления датчика
class SensorView: UIView {
    
    // Структура для определения размеров и констант макета
    struct Layout {
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    // Текущий выбранный параметр
    var currentParameter: Parameter = .airQuality
    
    // Основной вертикальный stack view
    let primaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.layer.cornerRadius = 26
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        stack.layoutMargins = insets
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    // Второстепенный вертикальный stack view
    let secondaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stack.layoutMargins = insets
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    // Главная кнопка, показывающая текущий параметр
    private lazy var mainButton: UIButton = {
        let button: UIButton = createButton(title: "Air Quality".uppercased(), action: #selector(mainButtonTapped), height: 58, target: self)
        button.setImage(UIImage.init(systemName: "chevron.down"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        return button
    }()
    
    // Кнопка для выбора качества воздуха
    private lazy var airQualityButton: UIButton = {
        let button = createButton(title: "Air Quality", action: #selector(airQualityButtonTapped), height: 45, target: self)
        button.isHidden = true
        button.contentHorizontalAlignment = .leading
        button.setImage(UIImage.init(systemName: "wind"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        return button
    }()
    
    // Кнопка для выбора индекса ультрафиолетового излучения
    private lazy var uvIndexButton: UIButton = {
        let button = createButton(title: "UV index", action: #selector(uvIndexButtonTapped), height: 45, target: self)
        button.isHidden = true
        button.contentHorizontalAlignment = .leading
        button.setImage(UIImage.init(systemName: "sun.max.fill"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        return button
    }()
    
    // Кнопка для вывода дополнительной информации
    private lazy var infoButton: UIButton = {
        let button = createButton(title: "What is this?", action: #selector(mainButtonTapped), height: 58, target: self)
        button.isHidden = true
        
        if let currentTitle = button.title(for: .normal) {
            let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            
            let attributedTitle = NSAttributedString(string: currentTitle, attributes: attributes)
            button.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        return button
    }()
    
    // Круглая кнопка для визуализации текущего параметра
    private lazy var roundButton: UIButton = {
        let button = UIButton()
        let roundButtonDiameter: CGFloat = 75
        button.backgroundColor = .cyan
        button.layer.cornerRadius = roundButtonDiameter / 2
        button.widthAnchor.constraint(equalToConstant: roundButtonDiameter).isActive = true
        button.heightAnchor.constraint(equalToConstant: roundButtonDiameter).isActive = true
        button.setImage(UIImage.init(systemName: "wind"), for: .normal)
        return button
    }()
    
    // Инициализатор
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод для настройки представлений
    func setupViews() {
        self.addSubview(primaryStackView)
        primaryStackView.addArrangedSubview(mainButton)
        primaryStackView.addArrangedSubview(secondaryStackView)
        secondaryStackView.addArrangedSubview(airQualityButton)
        secondaryStackView.addArrangedSubview(uvIndexButton)
        primaryStackView.addArrangedSubview(infoButton)
        self.addSubview(roundButton)
        
    }
    
    // Метод для настройки ограничений
    func setupConstraints() {
        primaryStackView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(30)
        }
        
        roundButton.snp.makeConstraints { make in
            make.centerY.equalTo(mainButton)
            make.right.equalTo(primaryStackView).offset(20)
        }
    }
    
    // Метод для создания кнопок, чтобы не копировать код
    private func createButton(title: String, action: Selector, height: CGFloat, target: Any) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.addTarget(target, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: Layout.screenWidth * 0.6).isActive = true
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        return button
    }
    
    // Действие при нажатии на главную кнопку
    @objc private func mainButtonTapped() {
        let areButtonsHidden = airQualityButton.isHidden
        
        airQualityButton.isHidden.toggle()
        uvIndexButton.isHidden.toggle()
        infoButton.isHidden.toggle()
        
        let image = areButtonsHidden ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        mainButton.setImage(image, for: .normal)
    }
    
    // Действие при нажатии на кнопку качества воздуха
    @objc private func airQualityButtonTapped() {
        mainButton.setTitle("Air Quality".uppercased(), for: .normal)
        airQualityButton.isHidden = true
        uvIndexButton.isHidden = true
        infoButton.isHidden = true
        roundButton.setImage(UIImage.init(systemName: "wind"), for: .normal)
        mainButton.setImage(UIImage.init(systemName: "chevron.down"), for: .normal)
    }
    
    // Действие при нажатии на кнопку индекса ультрафиолетового излучения
    @objc private func uvIndexButtonTapped() {
        mainButton.setTitle("UV index".uppercased(), for: .normal)
        airQualityButton.isHidden = true
        uvIndexButton.isHidden = true
        infoButton.isHidden = true
        roundButton.setImage(UIImage.init(systemName: "sun.max.fill"), for: .normal)
        mainButton.setImage(UIImage.init(systemName: "chevron.down"), for: .normal)
    }
}


