//
//  ContentView.swift
//  TicTacToe
//
//  Created by Prakash Bist on 03/05/2021.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
            VStack {

                Spacer()
                HStack{
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.red)
                    Text("VS")
                        .foregroundColor(.red)
                    Image(systemName: viewModel.singleModeOn ? "pc" : "person.crop.circle")
                        .foregroundColor(.red)
                }.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding()
                Spacer()
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
                Circle()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .overlay(
                    Image(systemName: "house.circle")
                    ).font(.largeTitle)
                    .foregroundColor(.white)
                    .overlay(Button(
                                "        ",
                                action: { self.presentationMode.wrappedValue.dismiss() }))
                Spacer()
            }.padding()
            .background(Color(.systemBackground))
            .ignoresSafeArea()
            .disabled(viewModel.isBoardDisabled)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                      }))
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            viewModel.fetchGameSettings()
        })
    }
    
 
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark":"circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.red).opacity(0.9)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
