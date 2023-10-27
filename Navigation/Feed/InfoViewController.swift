import UIKit

class InfoViewController: UIViewController {

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Look", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        view.backgroundColor = .systemGray5
        view.addSubview(actionButton)
        setupContraints()
        actionButton.addTarget(self, action: #selector(alertViewController(_:)), for: .touchUpInside)
    }
    
    private func setupContraints(){
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
                ),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    @objc func alertViewController(_ sender: UIAlertController) {
        let alertController = UIAlertController(title: "Information", message: "Information first", preferredStyle: .alert)

        let actionFirst = UIAlertAction(title: "Left", style: .default, handler: nil)
        let actionSecond = UIAlertAction(title: "Right", style: .default, handler: nil)
        
        alertController.addAction(actionFirst)
        print("Pressed the button \(actionFirst)")
        alertController.addAction(actionSecond)
        print("Pressed the button \(actionSecond)")
        self.present(alertController, animated: true)
        }
}
