//
//  MainView.swift
//  TicTacToe
//
//  Created by Prakash Bist on 04/05/2021.
//

import SwiftUI

struct MainView: View {
    
    @State var singleModeOn: Bool = false
    @State var doubleModeOn: Bool = false
    @State var normalLevelOn: Bool = false
    @State var difficultLevelOn: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "gamecontroller")
                    .foregroundColor(.red)
                
                Text("TicTacToe")
                    .foregroundColor(.red)
            }.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            NavigationView{
                VStack{
                    VStack{
                        Text("Select Mode")
                            .foregroundColor(.red)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        
                        Rectangle()
                            .foregroundColor(singleModeOn ? Color(red: 0.9, green: 0.9, blue: 0.9) : .red)
                            .frame(height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(50)
                            .onTapGesture {
                                singleModeOn = true
                                doubleModeOn = false
                                UserDefaults.standard.setValue(true, forKey: "singleMode")
                            }
                            .overlay(
                                HStack {
                                    Text("Single Player")
                                        .foregroundColor(singleModeOn ? .red : .white)
                                        .font(.title)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                }
                            )
                        Rectangle()
                            .foregroundColor(doubleModeOn ? Color(red: 0.9, green: 0.9, blue: 0.9) : .red)
                            .frame(height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(50)
                            .onTapGesture {
                                doubleModeOn = true
                                singleModeOn = false
                                UserDefaults.standard.setValue(false, forKey: "singleMode")
                            }
                            .overlay(
                                HStack {
                                    Text("Two Player")
                                        .foregroundColor(doubleModeOn ? .red : .white)
                                        .font(.title)
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                }
                            )
                    }
                    Spacer()
                    VStack{
                        Text("Select Level")
                            .foregroundColor(.red)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                        Rectangle()
                            .foregroundColor(normalLevelOn ? Color(red: 0.9, green: 0.9, blue: 0.9) : .red)
                            .frame(height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(50)
                            .onTapGesture {
                                normalLevelOn = true
                                difficultLevelOn = false
                                UserDefaults.standard.setValue(true, forKey: "normalLevel")

                            }
                            .overlay(
                                HStack {
                                    Text("Normal")
                                        .foregroundColor(normalLevelOn ? .red : .white)
                                        .font(.title)
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                }
                            )
                        Rectangle()
                            .foregroundColor(difficultLevelOn ? Color(red: 0.9, green: 0.9, blue: 0.9) : .red)
                            .frame(height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(50)
                            .onTapGesture {
                                difficultLevelOn = true
                                normalLevelOn = false
                                UserDefaults.standard.setValue(false, forKey: "normalLevel")
                            }
                            .overlay(
                                HStack {
                                    Text("Difficult")
                                        .foregroundColor(difficultLevelOn ? .red : .white)
                                        .font(.title)
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                }
                            )
                    }
                    Spacer()
                    NavigationLink(
                        destination: GameView() ,
                        label: {
                            Circle()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(((singleModeOn || doubleModeOn) && (normalLevelOn || difficultLevelOn)) ? .red : Color(.systemBackground))
                                .overlay(
                                    Text(" PLAY ")
                                        .foregroundColor(((singleModeOn || doubleModeOn) && (normalLevelOn || difficultLevelOn)) ? .white : Color(.systemBackground))
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                )
                        }).disabled(!((singleModeOn || doubleModeOn) && (normalLevelOn || difficultLevelOn))) // only true when each of mode and level are on
                        
                }
            }
        }.background(Color(.systemBackground))
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
