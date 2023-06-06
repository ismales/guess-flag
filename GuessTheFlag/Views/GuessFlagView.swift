//
//  GuessFlagView.swift
//  GuessTheFlag
//
//  Created by Сманчос on 08.05.2023.
//

import SwiftUI

struct GuessFlagView: View {

    @StateObject private var countries = Countries()
    @State private var score = UserDefaults.standard.integer(forKey: "score")
    @State private var correctAnswer = Int.random(in: 1...Resources.cellsNumber)
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var confettiAnimation = false

    private let twoColumnGrid = [GridItem(), GridItem()]

    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    LazyVStack {
                        Text(countries.countries[correctAnswer].uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: Resources.Metric.textSize))
                            .fontWeight(.bold)
                            .padding(.bottom, 40)
                        ZStack {
                            LazyVGrid(columns: twoColumnGrid, alignment: .center) {
                                ForEach(1...Resources.cellsNumber, id: \.self) { name in
                                    Button {
                                        flagTapped(name)
                                        correctAnswer = Int.random(in: 1...Resources.cellsNumber)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            confettiAnimation = false
                                        }
                                    } label: {
                                        FlagView(name: countries.countries[name])
                                    }
                                }
                            }
                            if confettiAnimation {
                                CofettieView()
                            }
                        }
                        .padding(.bottom, 55)
                        Text("счет".uppercased())
                            .font(.system(size: Resources.Metric.textSize))
                            .foregroundColor(.white)
                        Text("\(score)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 55))
                    }
                    .alert(Resources.Text.alertText.randomElement()!, isPresented: $showAlert) {
                        Button("продолжить".uppercased()) {
                            resume()
                        }
                    } message: {
                        Text(alertMessage)
                    }
                    Spacer()
                }
            }
            .background(Color("BackgroundColor"))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("найди флаг".uppercased())
                            .font(.system(size: Resources.Metric.navTitle))
                            .foregroundColor(.white)
                    }.padding(.top, 30)
                }
            }
        }
    }

    private func resume() {
        countries.countries.shuffle()
    }

    private func flagTapped(_ name: Int) {
        if name == correctAnswer {
            countries.countries.shuffle()
            confettiAnimation = true
            score += 1
            UserDefaults.standard.set(score, forKey: "score")
        } else {
            alertMessage = "Это \(countries.countries[name].uppercased())"
            showAlert = true
            score -= 1
            UserDefaults.standard.set(score, forKey: "score")
        }
    }
}

struct GuessFlagView_Previews: PreviewProvider {
    static var previews: some View {
        GuessFlagView()
    }
}
