//
//  ViewController.swift
//  comcom1
//
//  Created by 김응진 on 2022/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("\(segue.identifier!)세그웨이가 곧 실행됩니다.")
    }
    
    //코드상으로 화면 전환하기
    @IBAction func moveNext(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let uvc = storyboard.instantiateViewController(withIdentifier: "SecondVC")
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else { return }
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//        uvc.modalPresentationStyle = .fullScreen
        self.present(uvc,animated: true)
    }
    //네비게이션상으로 화면 전환하기
    @IBAction func moveByNav(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "NavSecondVC") else { return }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    //메뉴얼 세그로 화면 전환하기
    @IBAction func wind(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func goHome(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func uiBtn(_ sender: Any) {
        if self.uiTitle.text=="첫번째 화면"{
            self.uiTitle.text = "Hello, World!"
        } else if self.uiTitle.text == "Hello, World!" {
            self.uiTitle.text = "Bye, World!"
        } else {
            self.uiTitle.text = "첫번째 화면"
        }
    }
    
}

