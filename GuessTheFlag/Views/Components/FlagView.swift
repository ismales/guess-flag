//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by Сманчос on 08.05.2023.
//

import SwiftUI

struct FlagView: View {
    var name: String

    var body: some View {
        Image(name)
            .resizable()
            .frame(width: 180, height: 160)
            .shadow(color: .black, radius: 5)
            .padding(10)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(name: "бразилия")
    }
}
