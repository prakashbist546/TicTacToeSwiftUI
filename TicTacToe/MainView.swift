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
                    .font(.title)
                CustomText(text: "TicTacToe")
            }
            NavigationView{
                VStack{
                    VStack{
                        CustomText(text: "Select Mode")
                        CustomButton(buttonOn: singleModeOn, buttonName: "Single Player")
                            .onTapGesture {
                                singleModeOn = true
                                doubleModeOn = false
                                UserDefaults.standard.setValue(true, forKey: "singleMode")
                            }
                        
                        CustomButton(buttonOn: doubleModeOn, buttonName: "Double Player")
                            .onTapGesture {
                                doubleModeOn = true
                                singleModeOn = false
                                UserDefaults.standard.setValue(false, forKey: "singleMode")
                            }
                    }
                    Spacer()
                    VStack{
                        CustomText(text: "Select level")
                        CustomButton(buttonOn: normalLevelOn, buttonName: "Normal")
                            .onTapGesture {
                                normalLevelOn = true
                                difficultLevelOn = false
                                UserDefaults.standard.setValue(true, forKey: "normalLevel")
                            }
                        
                        CustomButton(buttonOn: difficultLevelOn, buttonName: "Difficult")
                            .onTapGesture {
                                difficultLevelOn = true
                                normalLevelOn = false
                                UserDefaults.standard.setValue(false, forKey: "normalLevel")
                            }
                    }
                    Spacer()
                    NavigationLink(
                        destination: GameView() ,
                        label: {
                            Circle()
                                .frame(width: 100, height: 100, alignment: .center)
                                .foregroundColor(((singleModeOn || doubleModeOn) && (normalLevelOn || difficultLevelOn)) ? .red : Color(.systemBackground))
                                .overlay(
                                    Text(" PLAY ")
                                        .foregroundColor(((singleModeOn || doubleModeOn) && (normalLevelOn || difficultLevelOn)) ? .white : Color(.systemBackground))
                                        .font(.title)
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

struct CustomButton: View {
    
    var buttonOn: Bool
    var buttonName: String
    var body: some View {
        Rectangle()
            .foregroundColor(buttonOn ? Color(red: 0.9, green: 0.9, blue: 0.9) : .red)
            .frame(height: 70, alignment: .center)
            .cornerRadius(50)
            .overlay(
                HStack {
                    Text(buttonName)
                        .foregroundColor(buttonOn ? .red : .white)
                        .font(.title)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            )
    }
}

struct CustomText: View {
    
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.red)
            .font(.title)
    }
}
