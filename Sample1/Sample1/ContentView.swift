//
//  ContentView.swift
//  Sample1
//
//  Created by Cameron Daniels Lawson on 1/13/21.
//  Copyright © 2021 Cameron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
       // Text("I was right")
        GeometryReader { geometry in
            VStack {
                HSplitView {
                    VStack { VideoController(metrics: geometry)
                    }.frame(width: geometry.size.width * 0.5)
                    VStack { Text("Pane 2") }.frame(width: 1.0).frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
