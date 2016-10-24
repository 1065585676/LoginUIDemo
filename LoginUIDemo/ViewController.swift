//
//  ViewController.swift
//  LoginUIDemo
//
//  Created by wangyuanyuan on 23/10/2016.
//  Copyright © 2016 wangyuanyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: 控件绑定
    @IBOutlet weak var dot: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var logerror: UIButton!
    @IBOutlet weak var superLook: UIButton!
    
    // MARK: 自定义变量
    let ai = UIActivityIndicatorView(activityIndicatorStyle: .white) // 等待环形进度条
    var loginPositon = CGPoint.zero // 记录login按钮初始位置
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // MARK: 设置代理
        username.delegate = self
        password.delegate = self
        
        self.login.center = self.logerror.center
        loginPositon = self.login.center
        
        self.logo.center.x -= self.view.frame.width
        self.dot.center.x -= self.view.frame.width/2
        self.username.center.x -= self.view.frame.width
        self.password.center.x -= self.view.frame.width
        self.login.center.x -= self.view.frame.width
        
        let paddingViewUser = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.username.frame.height))
        username.leftView = paddingViewUser
        username.leftViewMode = .always
        //username.addSubview(UIImageView(image: UIImage(named: "profile")))
        
        let profileView = UIImageView(image: UIImage(named: "profile"))
        profileView.frame.origin = CGPoint(x: 10, y: 11)
        self.username.addSubview(profileView)
        
        let paddingViewPasswd = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: self.username.frame.height))
        password.leftView = paddingViewPasswd
        password.leftViewMode = .always
        //password.addSubview(UIImageView(image: UIImage(named: "profile")))
        
        let lockpadView = UIImageView(image: UIImage(named: "lockpad"))
        lockpadView.frame.origin = CGPoint(x: 10, y: 11)
        self.password.addSubview(lockpadView)
        
        ai.frame.origin = CGPoint(x: 12, y: 12)
        self.login.addSubview(ai)
    }
    
    // MARK: View出现和消失
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.logo.center.x += self.view.frame.width
            }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
            self.dot.center.x += self.view.frame.width/2
            }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.username.center.x += self.view.frame.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.password.center.x += self.view.frame.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.1, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.login.center.x += self.view.frame.width
            }, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.logo.center.x -= self.view.frame.width
        self.dot.center.x -= self.view.frame.width/2
        self.username.center.x -= self.view.frame.width
        self.password.center.x -= self.view.frame.width
        self.login.center.x -= self.view.frame.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 登录按钮点击
    @IBAction func LoginTapped(_ sender: AnyObject) {
        ai.startAnimating()
        
        if self.loginPositon.y != self.login.center.y {
            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                self.login.center = self.loginPositon
                }, completion: nil)
            UIView.transition(with: self.logerror, duration: 0.2, options: .transitionFlipFromTop, animations: {
                self.logerror.isHidden = true
                }, completion: nil)
        }
        
        self.login.center.x -= 30
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: {
            self.login.center.x += 30
            }, completion: { _ in
//                for i in 0 ..< 100 {
//                    print(i)
//                }
                if let user = self.username.text, let pass = self.password.text , user == pass {
                    // MARK: 页面跳转
                    
                    //            let alertController = UIAlertController(title: "Success", message: "Login Successed!", preferredStyle: .alert)
                    //            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    //            alertController.addAction(alertAction)
                    //            self.present(alertController, animated: true, completion: nil)
                    
                    //                    if let sbViewController = self.storyboard?.instantiateViewController(withIdentifier: "testViewToView") {
                    //                        self.present(sbViewController, animated: true, completion: nil)
                    //                    }
                    
                    self.performSegue(withIdentifier: "LoginSuccess", sender: self)
                    //self.dismiss(animated: false, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                        self.login.center.y += self.logerror.frame.height + 8
                        }, completion: nil)
                    UIView.transition(with: self.logerror, duration: 0.2, options: .transitionFlipFromTop, animations: {
                        self.logerror.isHidden = false
                        }, completion: nil)
                }
                self.ai.stopAnimating()
        })
    }
    
    // MARK: 页面跳转segue传值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSuccess" {
            let toVC = segue.destination as! MainFaceViewController
            //
            toVC.welcomePassingText = username.text! + ":" + password.text!
        }
    }
    
    // MARK: Textfield 代理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "passwd" {
            superLook.isHidden = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "passwd" {
            superLook.isHidden = true
        }
    }
    
    // MARK: 主屏幕touch事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    // MARK: 密码查看明文
    @IBAction func touchDownShow(_ sender: AnyObject) {
        password.isSecureTextEntry = false
    }
    @IBAction func touchUpInsideHide(_ sender: AnyObject) {
        password.isSecureTextEntry = true
    }
    @IBAction func touchUpOutsideHide(_ sender: AnyObject) {
        password.isSecureTextEntry = true
    }
}

