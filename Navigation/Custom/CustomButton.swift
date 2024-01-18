import UIKit

class CustomButton: UIButton {
    typealias Action = (() -> Void)
    
    var someAction: Action
    
    init(title: String, titleColor: UIColor, tabAction: @escaping Action) {
        someAction = tabAction
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12.0
        backgroundColor = UIColor(red: 81/255, green: 129/255, blue: 184/255, alpha: 1)
        clipsToBounds = true
        addTarget(nil, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        someAction()
    }
}

