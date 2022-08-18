//
//  ContentView.swift
//  CeMeal
//
//  Created by Eddo Careera Iriyanto Putra on 18/08/22.
//

import SwiftUI

struct ContentView: View {
    @State var goToTabbedView: Bool = UserDefaults.standard.bool(forKey: "opened_once")

    var body: some View {
        if goToTabbedView {
            TabbedView()
        } else {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
