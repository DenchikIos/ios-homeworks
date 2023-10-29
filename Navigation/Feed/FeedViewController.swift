import UIKit

class FeedViewController: UIViewController {

    var post = PostFeed(title: "Post")
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    
        addPostButton(title: "First post", color: .systemBlue, to: stackView, selector: #selector(buttonPressed))
        addPostButton(title: "Second post", color: .systemTeal, to: stackView, selector: #selector(buttonPressed))
        addPostButton(title: "Third post", color: .systemMint, to: stackView, selector: #selector(buttonPressed))
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setupContraints()
    }
    
    private func setupContraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 220),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -30)
        ])
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: selector, for: .touchUpInside)

        view.addArrangedSubview(button)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
