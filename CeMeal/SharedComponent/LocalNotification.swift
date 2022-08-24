//
//  LocalNotification.swift
//  CeMeal
//
//  Created by Rafik Lutfi on 25/08/22.
//

import SwiftUI

class NotificationManager {
    
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization() {
        let options : UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("success  ")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "this is my first Notif"
        content.subtitle = "Aku mau diingatkan CeMeal"
        content.sound = .default
        content.badge = 1
        
        //time
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        //Calender
        //location
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

struct LocalNotification: View {
    var body: some View {
        VStack (spacing : 40) {
            Button ("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button ("Schedule Notif") {
                NotificationManager.instance.scheduleNotification()
            }
        }
    }
}

struct LocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotification()
    }
}
