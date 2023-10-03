//
//  ContentView.swift
//  PhonedleApp
//
//  Created by Justin Gonzales on 4/14/23.
//

import SwiftUI

struct ContentView: View {
    var gameView = NormalGameView()
    
    @State private var isAnimating = false
    @State private var showGameView = false
    @State private var zoomInEffect = false
    @State private var showSelectView = false

    
    
    var body: some View {
        
        
        ZStack{
            if showGameView{
                NormalGameView()
            }
            if !showGameView{
                VStack {
                    Spacer()
                    Text("Phonedle")
                        .font(Font.custom("DimboRegular", size:90))
                        .scaleEffect(isAnimating ? 1.2 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 50, damping: 3).delay(0.5))
                        .onAppear {
                            self.isAnimating = true
                        }
                    
                    Text("Can you guess the iPhone?")
                        .font(Font.custom("DimboRegular", size:25))
                        .scaleEffect(isAnimating ? 1.2 : 1)
                        .animation(Animation.interpolatingSpring(stiffness: 50, damping: 3).delay(0.5))
                        .onAppear {
                            self.isAnimating = true
                        }
                    
                    Spacer()
                    
                    Button("START") {
                        showSelectView = true
                        withAnimation(.easeInOut(duration: 0.5)) {
                            zoomInEffect = true
                        }

                        
                        
                    }
                    .buttonStyle(.bordered)
                    .font(Font.custom("DimboRegular", size:35))
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(25)
                    .scaleEffect(isAnimating ? 1.2 : 1)
                    .animation(Animation.interpolatingSpring(stiffness: 50, damping: 3).delay(0.5))
                    .onAppear {
                        self.isAnimating = true
                    }
                    .fullScreenCover(isPresented: $showSelectView) {
                                    SelectView()
                                }
                    
                    
                    Spacer()
                    
                    
                    Text("Created by Justin Gonzales")
                        .font(Font.custom("DimboRegular", size:25))

                    
                }
                .padding()
                .scaleEffect(zoomInEffect ? 50 : 1)
                .animation(.easeInOut(duration: 0.5))
                
                
                
                
            }
                
            
            
        }
        
        
        
        
        
        
        
    }
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
