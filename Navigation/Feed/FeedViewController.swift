import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    //MARK: - Puplic Properties

    var post = PostFeed(title: "Мой пост")
    let feedModel: FeedViewModelProtocol
    let coordinator: FeedCoordinator
    
    private lazy var buttonAction: (() -> Void) = {
            self.coordinator.presentPost(navigationController:
            self.navigationController, title:
            self.post.title)
        }

    //MARK: - Private Properties
    
    private lazy var feedScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        var firstButton = CustomButton(title: "First post", titleColor: .black) { [unowned self] in
            buttonAction()
        }
        stackView.addArrangedSubview(firstButton)
        var secondButton = CustomButton(title: "Second post", titleColor: .black) { [unowned self] in
            buttonAction()
        }
        stackView.addArrangedSubview(secondButton)
        return stackView
    }()
    
    private lazy var checkSecretWordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter secret word:"
        textField.textAlignment = .center
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    private lazy var checkGuessButton = CustomButton(title: "Secret word check", titleColor: .white) { [unowned self] in actionSetStatusButtonPressed()
        }
    
    private lazy var resultLabelOfSecretWord: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    //MARK: - Init
    
    init(coordinator: FeedCoordinator) {
            self.feedModel = FeedViewModel()
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObrervers()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 223/255, alpha: 1)
        checkSecretWordTextField.delegate = self
        view.addSubview(feedScrollView)
        feedScrollView.addSubview(contentView)
        contentView.addSubviews(stackView, checkSecretWordTextField, checkGuessButton, resultLabelOfSecretWord)
        
        setupContraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Puplic Methods
    
    func addObrervers() {
        NotificationCenter.default.addObserver(self, selector: #selector(trueSelector), name: NSNotification.Name(rawValue: "Word is correct") , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(falseSelector), name: NSNotification.Name(rawValue: "Word is not correct") , object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is correct"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is not correct"), object: nil)
    }
    
    //MARK: - Private Methods
    
    private func actionSetStatusButtonPressed() {
            checkSecretWordTextField.endEditing(true)
            
            if checkSecretWordTextField.text != nil && checkSecretWordTextField.text?.count != 0 {
                feedModel.check(inputSecretWord: checkSecretWordTextField.text ?? "")
            }
    }
        
    @objc func trueSelector() {
            resultLabelOfSecretWord.text = "Угадал секретное слово"
            resultLabelOfSecretWord.textColor = .green
            resultLabelOfSecretWord.layer.borderColor = UIColor.green.cgColor
            resultLabelOfSecretWord.alpha = 1
    }

    @objc func falseSelector() {
            resultLabelOfSecretWord.text = "Не угадал секретное слово"
            resultLabelOfSecretWord.textColor = .red
            resultLabelOfSecretWord.layer.borderColor = UIColor.red.cgColor
            resultLabelOfSecretWord.alpha = 1
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            feedScrollView.contentOffset.y = keyboardSize.height - (feedScrollView.frame.height - checkGuessButton.frame.minY)
            feedScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardHide(notification: NSNotification) {
        feedScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func setupContraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            feedScrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            feedScrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            feedScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            feedScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: feedScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: feedScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: feedScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: feedScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: feedScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: feedScrollView.centerYAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -32),
            
            checkSecretWordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            checkSecretWordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkSecretWordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkSecretWordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            checkGuessButton.topAnchor.constraint(equalTo: checkSecretWordTextField.bottomAnchor, constant: 20),
            checkGuessButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabelOfSecretWord.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resultLabelOfSecretWord.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            resultLabelOfSecretWord.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            resultLabelOfSecretWord.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

//MARK: - Extension

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

