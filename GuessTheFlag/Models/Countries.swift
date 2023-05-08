//
//  Model.swift
//  GuessTheFlag
//
//  Created by Сманчос on 08.05.2023.
//

import SwiftUI

class Countries: ObservableObject {
    @Published var countries = ["бразилия", "китай", "европа", "индия", "италия", "япония", "США", "вьетнам"].shuffled()
}
