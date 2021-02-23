//
//  SwiftUIARAlbumArtView.swift
//  ARTracker
//
//  Created by Ravi Rachamalla on 2021-02-23.
//

import SwiftUI

struct SwiftUIARAlbumArtView: View {
    var body: some View {
        // set up a basic bacground ui with a Zstack to
        ZStack{
            // Rouded rectangle with a gradient as our background
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.purple]), startPoint: .topLeading, endPoint: .trailing))
                .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct SwiftUIARAlbumArtView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIARAlbumArtView()
    }
}
