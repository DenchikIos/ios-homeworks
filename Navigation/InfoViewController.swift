import UIKit

class InfoViewController: UIViewController {

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Viewing", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Info"
        view.backgroundColor = .systemMint
        view.addSubview(actionButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
             NSLayoutConstraint.activate([
                 actionButton.leadingAnchor.constraint(
                     equalTo: safeAreaLayoutGuide.leadingAnchor,
                     constant: 20.0),
                 actionButton.trailingAnchor.constraint(
                     equalTo: safeAreaLayoutGuide.trailingAnchor,
                     constant: -20.0),
                 actionButton.centerYAnchor.constraint(
                     equalTo: safeAreaLayoutGuide.centerYAnchor),
                 actionButton.heightAnchor.constraint(equalToConstant: 44.0)])

             actionButton.addTarget(self, action: #selector(alertViewController(_:)), for: .touchUpInside)
    }
    
    @objc func alertViewController(_ sender: UIAlertController) {
           let alertController = UIAlertController(title: "Output information", message: "Information", preferredStyle: .alert)

           let actionFirst = UIAlertAction(title: "Left", style: .default, handler: nil)
           let actionSecond = UIAlertAction(title: "Right", style: .default, handler: nil)
           
           alertController.addAction(actionFirst)
           print("Нажал на кнопку \(actionFirst)")
           alertController.addAction(actionSecond)
           print("Нажал на кнопку \(actionSecond)")
           self.present(alertController, animated: true)
           }
   }
