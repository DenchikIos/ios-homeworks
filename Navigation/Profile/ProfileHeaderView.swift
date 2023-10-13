import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private var statusText: String = "Set status"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cat.jpeg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 60.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Waiting for victory"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private var statusTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.text = "Set new status"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .gray
        textField.textAlignment = .left
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    private let setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        addTarget()
        statusTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addTarget() {
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc private func buttonPressed() {
        if let buttonText = setStatusButton.currentTitle {
            print(buttonText)
        }
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            fullNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 50),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27),
            fullNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            avatarImageView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            statusLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 50),
            statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -14),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 56),
            setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 50),
            statusTextField.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor, constant: -16),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -34),
        ])
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
 
