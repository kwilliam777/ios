//
//  AppDelegate.swift
//  comcom2
//
//  Created by 김응진 on 2022/10/09.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var paramEmail : String?
    var paramUpdate : Bool?
    var paramInterval : Double?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 10.0,*) {
            //경고창, 배지, 사운드를 사용하는 알림환경정보를 생성하고, 사용자 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (didAllow, e) in }
            notiCenter.delegate = self
        } else {
            print("else")
            let setting = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(setting)
        }
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = " 준비된 내용이 아주 많아요! 얼른 다시 앰을 열어주세요!!"
                    nContent.body = "앗! 왜 나갔어요???어서 들어오세요!!"
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name": "홍길동"]
                    //알림 발송 조건 객체
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    //알림 요청 객체
                    let request = UNNotificationRequest (identifier: "wakeup",content: nContent, trigger: trigger)
                    //노티피케이션 센터에 추가
                    UNUserNotificationCenter.current ().add(request)
                } else {
                    print (" 사용자가 동의하지 않음!!!")
                    let setting = application.currentUserNotificationSettings
                    guard setting?.types != Optional.none else {
                        print("Can't Schedule")
                        return
                    }
                    
                    let noti = UILocalNotification()
                    noti.fireDate = Date(timeIntervalSinceNow: 10)
                    noti.timeZone = TimeZone.autoupdatingCurrent
                    noti.alertBody = "얼른다시 접속하세요!!"
                    noti.alertAction = "학습하기"
                    noti.applicationIconBadgeNumber = 1
                    noti.soundName = UILocalNotificationDefaultSoundName
                    noti.userInfo = ["name": "홍길동"]
                    
                    application.scheduleLocalNotification(noti)
                }
            }
        } else {
            print("9 or less")
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "wakeup" {
            let userInfo = notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler([.alert,.badge,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            print(userInfo["name"]!)
        }
        completionHandler()
    }
    
}

