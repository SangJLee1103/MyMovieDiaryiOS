//
//  ToastMessage.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/11/07.
//

import UIKit

public func showToast(message: String, duration: Double = 2.0, font: UIFont = .systemFont(ofSize: 14), view: UIView) {
    
    let toastView: UIView = {
        let toastView = UIView()
        toastView.backgroundColor = .red.withAlphaComponent(0.7)
        toastView.alpha = 1.0
        toastView.layer.cornerRadius = 16
        toastView.clipsToBounds  =  true
        toastView.translatesAutoresizingMaskIntoConstraints = false
        return toastView
    }()
    
    let toastLabel: UILabel = {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 2
        toastLabel.font = font
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        return toastLabel
    }()
    
    view.addSubview(toastView)
    toastView.addSubview(toastLabel)
    
    NSLayoutConstraint.activate([
        toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        toastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        toastView.widthAnchor.constraint(equalToConstant: 250),
        toastView.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    NSLayoutConstraint.activate([
        toastLabel.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
        toastLabel.centerYAnchor.constraint(equalTo: toastView.centerYAnchor)
    ])
    
        
    UIView.animate(withDuration: 2.0, delay: duration, options: .curveEaseOut, animations: {
        toastView.alpha = 0.0
    }, completion: {(isCompleted) in
        toastView.removeFromSuperview()
    })
}
