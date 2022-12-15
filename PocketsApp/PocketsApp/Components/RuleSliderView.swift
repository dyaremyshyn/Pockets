//
//  RuleSliderView.swift
//  PocketsApp
//
//  Created by User on 13/12/2022.
//

import UIKit

protocol SliderValueChangedProtocol {
    func sliderValueChanged(_ rangeSlider: RuleSlider)
}

class RuleSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
    }
}

class RuleSliderView: UIView {
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var slider: RuleSlider = {
        let view = RuleSlider()
        view.value = 0
        view.minimumValue = 0
        view.maximumValue = 100
        view.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var valueLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 25)
        view.text = "0%"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var completion: ((RuleSlider) -> ())?
    
    init(title: String, completion: @escaping (RuleSlider) -> ()) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.completion = completion
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() {
        addSubview(titleLabel)
        addSubview(slider)
        addSubview(valueLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        valueLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5).isActive = true
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RuleSlider) {
        rangeSlider.value = roundf(rangeSlider.value)
        print("Value: \(rangeSlider.value)\n")
        valueLabel.text = String(format: "%.0f", rangeSlider.value) + "%"
        sliderValueChanged(rangeSlider)
    }
    
    func setDefaultSliderValue(value: Float) {
        slider.value = value
        valueLabel.text = String(format: "%.0f", value) + "%"
    }
}

extension RuleSliderView : SliderValueChangedProtocol {
    func sliderValueChanged(_ rangeSlider: RuleSlider) {
        guard let completion = completion else { return }
        completion(rangeSlider)
    }
}
