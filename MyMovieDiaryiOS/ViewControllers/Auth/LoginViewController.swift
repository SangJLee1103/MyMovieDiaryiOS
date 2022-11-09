//
//  LoginViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/30.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private let titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.sizeToFit()
        titleLbl.font = .boldSystemFont(ofSize: 24)
        titleLbl.text = "MovieYA"
        titleLbl.textColor = .red
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        return titleLbl
    }()
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.borderStyle = .roundedRect
        emailField.backgroundColor = .darkGray
        emailField.tintColor = .black
        emailField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailField.placeholder = " 이메일 주소"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    let pwField: UITextField = {
        let pwField = UITextField()
        pwField.borderStyle = .roundedRect
        pwField.backgroundColor = .darkGray
        pwField.tintColor = .black
        pwField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        pwField.placeholder = " 비밀번호"
        pwField.translatesAutoresizingMaskIntoConstraints = false
        return pwField
    }()
    
    let loginBtn: UIButton = {
        let loginBtn = UIButton()
        loginBtn.backgroundColor = .red
        loginBtn.layer.cornerRadius = 5
        loginBtn.setTitle("로그인", for: .normal)
        loginBtn.titleLabel?.font = .systemFont(ofSize: 17)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        return loginBtn
    }()
    
    let joinBtn: UIButton = {
        let joinBtn = UIButton()
        joinBtn.titleLabel?.font = .systemFont(ofSize: 13)
        joinBtn.titleLabel?.textColor = .white
        joinBtn.setTitle("회원가입", for: .normal)
        joinBtn.setUnderline()
        joinBtn.translatesAutoresizingMaskIntoConstraints = false
        return joinBtn
    }()
    
    let findPwBtn: UIButton = {
        let findPwBtn = UIButton()
        findPwBtn.titleLabel?.font = .systemFont(ofSize: 13)
        findPwBtn.titleLabel?.textColor = .white
        findPwBtn.setTitle("비밀번호 재설정", for: .normal)
        findPwBtn.setUnderline()
        findPwBtn.translatesAutoresizingMaskIntoConstraints = false
        return findPwBtn
    }()
    
    let leftLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    let rightLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    let snsLoginLbl: UILabel = {
        let snsLoginLbl = UILabel()
        snsLoginLbl.sizeToFit()
        snsLoginLbl.textColor = .white
        snsLoginLbl.font = .systemFont(ofSize: 13, weight: .thin)
        snsLoginLbl.text = "SNS 계졍으로 로그인"
        snsLoginLbl.translatesAutoresizingMaskIntoConstraints = false
        return snsLoginLbl
    }()
    
    let googleBtn: UIButton = {
        let googleBtn = UIButton()
        googleBtn.setImage(.init(named: "google"), for: .normal)
        googleBtn.translatesAutoresizingMaskIntoConstraints = false
        return googleBtn
    }()
    
    let appleBtn: UIButton = {
        let appleBtn = UIButton()
        appleBtn.setImage(.init(named: "apple"), for: .normal)
        appleBtn.translatesAutoresizingMaskIntoConstraints = false
        return appleBtn
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        joinBtn.addTarget(self, action: #selector(join), for: .touchUpInside)
        findPwBtn.addTarget(self, action: #selector(findPw), for: .touchUpInside)
        googleBtn.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
    }
}

// MARK: - 뷰 관련
extension LoginViewController {
    private func setupView() {
        self.view.backgroundColor = .black
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        view.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
            titleLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        view.addSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 45),
            emailField.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(pwField)
        NSLayoutConstraint.activate([
            pwField.heightAnchor.constraint(equalToConstant: 45),
            pwField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            pwField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            pwField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.heightAnchor.constraint(equalToConstant: 45),
            loginBtn.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 20),
            loginBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            loginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(joinBtn)
        NSLayoutConstraint.activate([
            joinBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            joinBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -40)
        ])
        
        view.addSubview(findPwBtn)
        NSLayoutConstraint.activate([
            findPwBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            findPwBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 40)
        ])
        
        view.addSubview(snsLoginLbl)
        NSLayoutConstraint.activate([
            snsLoginLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height / 3) * 2 - 40),
            snsLoginLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        view.addSubview(leftLineView)
        NSLayoutConstraint.activate([
            leftLineView.heightAnchor.constraint(equalToConstant: 0.5),
            leftLineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height / 3) * 2 - 33),
            leftLineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            leftLineView.trailingAnchor.constraint(equalTo: snsLoginLbl.leadingAnchor, constant: -10)
        ])
        
        view.addSubview(rightLineView)
        NSLayoutConstraint.activate([
            rightLineView.heightAnchor.constraint(equalToConstant: 0.5),
            rightLineView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.view.frame.height / 3) * 2 - 33),
            rightLineView.leadingAnchor.constraint(equalTo: snsLoginLbl.trailingAnchor, constant: 10),
            rightLineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(googleBtn)
        NSLayoutConstraint.activate([
            googleBtn.widthAnchor.constraint(equalToConstant: 60),
            googleBtn.heightAnchor.constraint(equalToConstant: 60),
            googleBtn.topAnchor.constraint(equalTo: snsLoginLbl.bottomAnchor, constant: 10),
            googleBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
        ])
        
        view.addSubview(appleBtn)
        NSLayoutConstraint.activate([
            appleBtn.widthAnchor.constraint(equalToConstant: 60),
            appleBtn.heightAnchor.constraint(equalToConstant: 60),
            appleBtn.topAnchor.constraint(equalTo: snsLoginLbl.bottomAnchor, constant: 10),
            appleBtn.leadingAnchor.constraint(equalTo: googleBtn.trailingAnchor, constant: 10),
        ])
        
    }
}

extension LoginViewController {
    
    // 로그인
    @objc func login(_ sender: UIButton) {
        if let email = emailField.text, let password = pwField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    let font: UIFont = .systemFont(ofSize: 14)
                    let text = "입력하신 아이디 또는 비밀번호가 일치하지 않습니다."
                    let attributeString = NSMutableAttributedString(string: text)
                    attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
                    let alert = UIAlertController(title: text , message: "", preferredStyle: .alert)
                    alert.setValue(attributeString, forKey: "attributedTitle")
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self?.present(alert, animated: false)
                } else {
                    let nextVC = MainViewController()
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
    }
    
    // 회원가입 페이지로
    @objc func join(_ sender: UIButton) {
        let joinVC = JoinViewController()
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
    // 비밀번호 재설정
    @objc func findPw(_ sender: UIButton) {
        let alert = UIAlertController(title: "비밀번호 재설정", message: "회원가입한 이메일을 입력해주세요", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "이메일 주소"
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let enter = UIAlertAction(title: "확인", style: .default) { (_) in
            if let email = alert.textFields?[0].text {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let e = error {
                        print(e)
                    } else {
                        print(email)
                    }
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(enter)
        self.present(alert, animated: true)
    }
    
    // 구글 로그인 버튼 클릭시
    @objc func googleLogin(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
                print("구글 로그인 실패")
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    let font: UIFont = .systemFont(ofSize: 14)
                    let text = "구글 로그인에 실패하셨습니다."
                    let attributeString = NSMutableAttributedString(string: text)
                    attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
                    let alert = UIAlertController(title: text , message: "", preferredStyle: .alert)
                    alert.setValue(attributeString, forKey: "attributedTitle")
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self?.present(alert, animated: false)
                } else {
                    let nextVC = MainViewController()
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
        
    }
}


// MARK: 버튼 밑줄을 위한 확장
extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}
