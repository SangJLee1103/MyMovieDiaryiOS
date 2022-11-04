//
//  LoginViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/10/30.
//

import UIKit
import Firebase
import KakaoOpenSDK

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
    
    let kakaoBtn: UIButton = {
        let kakaoBtn = UIButton()
        kakaoBtn.setImage(.init(named: "kakao_login_large_wide"), for: .normal)
        kakaoBtn.imageView?.sizeToFit()
        kakaoBtn.contentVerticalAlignment = .fill
        kakaoBtn.contentHorizontalAlignment = .fill
        kakaoBtn.translatesAutoresizingMaskIntoConstraints = false
        return kakaoBtn
    }()
    
    let appleBtn: UIButton = {
        let appleBtn = UIButton()
        appleBtn.setImage(.init(named: "appleid_button"), for: .normal)
        appleBtn.contentVerticalAlignment = .fill
        appleBtn.contentHorizontalAlignment = .fill
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
        kakaoBtn.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
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
            emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(pwField)
        NSLayoutConstraint.activate([
            pwField.heightAnchor.constraint(equalToConstant: 45),
            pwField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            pwField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            pwField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(loginBtn)
        NSLayoutConstraint.activate([
            loginBtn.heightAnchor.constraint(equalToConstant: 45),
            loginBtn.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 20),
            loginBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
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
        
        view.addSubview(kakaoBtn)
        NSLayoutConstraint.activate([
            kakaoBtn.heightAnchor.constraint(equalToConstant: 45),
            kakaoBtn.topAnchor.constraint(equalTo: joinBtn.bottomAnchor, constant: 50),
            kakaoBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            kakaoBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
//        view.addSubview(appleBtn)
//        NSLayoutConstraint.activate([
//            appleBtn.heightAnchor.constraint(equalToConstant: 45),
//            appleBtn.topAnchor.constraint(equalTo: kakaoBtn.bottomAnchor, constant: 20),
//            appleBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
//            appleBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
//        ])
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
                        print("보내짐")
                    }
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(enter)
        self.present(alert, animated: true)
    }
    
    @objc func kakaoLogin(_ sender: UIButton) {
        
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
