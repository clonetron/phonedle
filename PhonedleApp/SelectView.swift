//
//  SelectView.swift
//  PhonedleApp
//
//  Created by Justin Gonzales on 5/2/23.
//

import SwiftUI

struct SelectView: View {
    @State private var showNormalGameView = false
    @State private var showRelaxedGameView = false
    
    var body: some View {
        
        VStack{
            
            
            
            Text("Phondle!")
                .font(Font.custom("DimboRegular", size: 40))

            
            Text("Select Your Gamemode")
                .padding(.vertical, 30)
                .font(Font.custom("DimboRegular", size: 45))
                
                .cornerRadius(35)
            Spacer()
            
            Button(action: {
                showNormalGameView = true
            }) {
                Text("Normal")
                    .font(Font.custom("DimboRegular", size: 60))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(35)
            }
            .fullScreenCover(isPresented: $showNormalGameView) {
                NormalGameView()
            }

            VStack{
                Text("Guess the iPhone model in 5 attempts.  ")
                    
            }
            .frame(width: 300)
            .padding(.horizontal, 80)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            
            Button(action: {
                showRelaxedGameView = true
            }) {
                Text("Relaxed")
                    .font(Font.custom("DimboRegular", size: 60))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(35)
            }
            .fullScreenCover(isPresented: $showRelaxedGameView) {
                RelaxedGameView()
            }

            VStack{
                Text("Guess the iPhone model with unlimited attempts.  ")
                    
            }
            .frame(width: 300) 
            .padding(.horizontal, 80)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            

        }
        .font(Font.custom("DimboRegular", size: 29))
        .padding()
        
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
