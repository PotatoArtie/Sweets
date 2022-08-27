//
//  FooterView.swift
//  Assignment
//
//  Created by Atlas on 2022/08/25.
//

import UIKit
import SnapKit
import Then

class FooterView: UIView {
    let indicator = UIActivityIndicatorView()
    
    public override init(frame:CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
}


extension FooterView {
    private func setupUI() {
        addSubview(indicator)
        backgroundColor = .red
        indicator.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
