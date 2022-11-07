//
//  JoinViewController.swift
//  MyMovieDiaryiOS
//
//  Created by 이상준 on 2022/11/01.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class JoinViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let emailLbl: UILabel = {
        let emailLbl = UILabel()
        emailLbl.sizeToFit()
        emailLbl.text = "이메일"
        emailLbl.textColor = .white
        emailLbl.translatesAutoresizingMaskIntoConstraints = false
        return emailLbl
    }()
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.borderStyle = .roundedRect
        emailField.backgroundColor = .darkGray
        emailField.tintColor = .black
        emailField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailField.placeholder = " 이메일"
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    let emailDuplicationBtn: UIButton = {
        let emailDuplicationBtn = UIButton()
        emailDuplicationBtn.titleLabel?.font = .systemFont(ofSize: 15)
        emailDuplicationBtn.setTitleColor(.red, for: .normal)
        emailDuplicationBtn.setTitle("중복확인", for: .normal)
        emailDuplicationBtn.translatesAutoresizingMaskIntoConstraints = false
        return emailDuplicationBtn
    }()
    
    
    let pwLbl: UILabel = {
        let pwLbl = UILabel()
        pwLbl.sizeToFit()
        pwLbl.text = "비밀번호"
        pwLbl.textColor = .white
        pwLbl.translatesAutoresizingMaskIntoConstraints = false
        return pwLbl
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
    
    // 비번 재입력 필드
    let pwReField: UITextField = {
        let pwReField = UITextField()
        pwReField.borderStyle = .roundedRect
        pwReField.backgroundColor = .darkGray
        pwReField.tintColor = .black
        pwReField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        pwReField.placeholder = " 비밀번호 확인"
        pwReField.translatesAutoresizingMaskIntoConstraints = false
        return pwReField
    }()
    
    let nicknameLbl: UILabel = {
        let nicknameLbl = UILabel()
        nicknameLbl.sizeToFit()
        nicknameLbl.text = "닉네임"
        nicknameLbl.textColor = .white
        nicknameLbl.translatesAutoresizingMaskIntoConstraints = false
        return nicknameLbl
    }()
    
    let nicknameField: UITextField = {
        let nicknameField = UITextField()
        nicknameField.borderStyle = .roundedRect
        nicknameField.backgroundColor = .darkGray
        nicknameField.tintColor = .black
        nicknameField.attributedPlaceholder = NSAttributedString(string:"placeholder text", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        nicknameField.placeholder = " 닉네임"
        nicknameField.translatesAutoresizingMaskIntoConstraints = false
        return nicknameField
    }()
    
    let nicknameDuplicationBtn: UIButton = {
        let nicknameDuplicationBtn = UIButton()
        nicknameDuplicationBtn.titleLabel?.font = .systemFont(ofSize: 15)
        nicknameDuplicationBtn.setTitleColor(.red, for: .normal)
        nicknameDuplicationBtn.setTitle("중복확인", for: .normal)
        nicknameDuplicationBtn.translatesAutoresizingMaskIntoConstraints = false
        return nicknameDuplicationBtn
    }()
    
  
    
    let joinButton: BottomButton = {
        let joinButton = BottomButton()
        joinButton.setButtonStyle(title: "회원가입")
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        return joinButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
        self.joinButton.delegate = self
    }
}

extension JoinViewController {
    private func setupView() {
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "회원가입"
    }
    
    private func setLayout() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        view.addSubview(emailLbl)
        NSLayoutConstraint.activate([
            emailLbl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            emailLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
        ])
        
        view.addSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 45),
            emailField.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 15),
            emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        emailField.addSubview(emailDuplicationBtn)
        NSLayoutConstraint.activate([
            emailDuplicationBtn.centerYAnchor.constraint(equalTo: emailField.centerYAnchor),
            emailDuplicationBtn.trailingAnchor.constraint(equalTo: emailField.trailingAnchor, constant: -10)
        ])
        
        view.addSubview(pwLbl)
        NSLayoutConstraint.activate([
            pwLbl.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30),
            pwLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
        ])
        
        view.addSubview(pwField)
        NSLayoutConstraint.activate([
            pwField.heightAnchor.constraint(equalToConstant: 45),
            pwField.topAnchor.constraint(equalTo: pwLbl.bottomAnchor, constant: 15),
            pwField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            pwField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(pwReField)
        NSLayoutConstraint.activate([
            pwReField.heightAnchor.constraint(equalToConstant: 45),
            pwReField.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 10),
            pwReField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            pwReField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        view.addSubview(nicknameLbl)
        NSLayoutConstraint.activate([
            nicknameLbl.topAnchor.constraint(equalTo: pwReField.bottomAnchor, constant: 30),
            nicknameLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
        ])
        
        view.addSubview(nicknameField)
        NSLayoutConstraint.activate([
            nicknameField.heightAnchor.constraint(equalToConstant: 45),
            nicknameField.topAnchor.constraint(equalTo: nicknameLbl.bottomAnchor, constant: 15),
            nicknameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            nicknameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        
        nicknameField.addSubview(nicknameDuplicationBtn)
        NSLayoutConstraint.activate([
            nicknameDuplicationBtn.centerYAnchor.constraint(equalTo: nicknameField.centerYAnchor),
            nicknameDuplicationBtn.trailingAnchor.constraint(equalTo: nicknameField.trailingAnchor, constant: -10)
        ])
        
        
        view.addSubview(joinButton)
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            joinButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            joinButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            joinButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}


// MARK: - 버튼 클릭에 대한 확장
extension JoinViewController {
    // email 중복 확인
    @objc func emailDuplication() {
        
        
    }
    
    // 닉네임 중복 확인
    @objc func nicknameDuplication() {
        
        
    }
}

// MARK: - 하단 버튼 프로토콜 구현
extension JoinViewController: BottomButtonProtocol {
    // 하단 회원가입 버튼 클릭시
    func didTapBottomButton() {
        
        if let email = self.emailField.text, let password = self.pwField.text, let nickname = self.nicknameField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print(e)
                }
                self.db.collection("user").addDocument(data: [
                    "email": email,
                    "password": password,
                    "nickname": nickname
                ]) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Successfully saved data")
                    }
                }
            }
        } 
    }
}
