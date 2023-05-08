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

    private let twoColumnGrid = [GridItem(), GridItem()]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, Color("BackgroundColor")]) , startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.bottom)
                VStack{
                    LazyVStack {
                        HStack(spacing: 40) {
                            VStack {
                                Text("Выберите флаг:")
                                    .font(.system(size: Resources.Metric.textSize))
                                Text(countries.countries[correctAnswer].capitalized)
                                    .foregroundColor(.red)
                                    .font(.system(size: Resources.Metric.textSize))
                                    .fontWeight(.bold)
                            }
                        }
                        LazyVGrid(columns: twoColumnGrid, alignment: .center) {
                            ForEach(1...Resources.cellsNumber, id: \.self) { name in
                                Button {
                                    flagTapped(name)
                                    correctAnswer = Int.random(in: 1...Resources.cellsNumber)
                                } label: {
                                    FlagView(name: countries.countries[name])
                                }
                            }
                        }
                    }
                    .alert("Неправильно", isPresented: $showAlert) {
                        Button("Продолжить") {
                            resume()
                        }
                    } message: {
                        Text(alertMessage)
                    }
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Угадай страну")
                            .fontWeight(.bold)
                            .font(.system(size: Resources.Metric.navTitle))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("Счет: \(score)")
                    }
                }
            }
        }
    }

    private func resume() {
        countries.countries.shuffle()
        correctAnswer = Int.random(in: 1...Resources.cellsNumber)
    }

    private func flagTapped(_ name: Int) {
        if name == correctAnswer {
            countries.countries.shuffle()
            score += 1
            UserDefaults.standard.set(score, forKey: "score")
        } else {
            alertMessage = "Это \(countries.countries[name].capitalized)"
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
