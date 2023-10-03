

import SwiftUI


struct RelaxedGameView: View {
    @State private var searchText = ""
    @State private var isListItemClicked = false
    @State private var guess = ""
    @State private var isShowingAlert = false
    @State private var phoneData: [Phones] = PhoneData.loadPhoneData()
    @State private var buttonText = "Enter Guess"
    @State private var showingAlert = false
    @State private var answer: Phones
    @State private var isGameOver = false
    @State private var isGameWonViewPresented = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    init() {
           let phones = PhoneData.loadPhoneData()
           self._answer = State(initialValue: phones.randomElement() ?? Phones(name: "", releaseYear: 0, processor: "", noCameras: 0, touchID: false, faceID: false, screenSize: 0, resolutionHeight: 0, resolutionWidth: 0))
            print(answer.name)

       }
    
    
    
    private func selectRandomPhone() {
        let phones = PhoneData.loadPhoneData()
        self.answer = phones.randomElement() ?? Phones(name: "", releaseYear: 0, processor: "", noCameras: 0, touchID: false, faceID: false, screenSize: 0, resolutionHeight: 0, resolutionWidth: 0)
        

    }
    
    private func onResetButtonPressed() {
        selectRandomPhone()
        guess = ""
        isShowingAlert = false
        showingAlert = false
        print(answer.name)
            isGameOver = false
        isGameWonViewPresented = false
        searchText = "";

    }
    
    func dismissKeyboard() {
        UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first?
            .endEditing(true)
    }
    
    
    
    var filteredData: [Phones] {
        phoneData.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var isSearchTextValid: Bool {
        searchText.isEmpty || phoneData.contains(where: { $0.name.lowercased().contains(searchText.lowercased()) })
    }
    
    func onEnterGuessButtonPressed() {
        dismissKeyboard()
        if !isGameOver {
            if isSearchTextValid{
                guess = searchText
                
            }

            if searchText != ""{
                buttonText = guess
            }

            if searchText == answer.name {
                isGameWonViewPresented = true

                
            }
        }
    }

    
    private var selectedPhone: Phones? {
        phoneData.first(where: { $0.name.lowercased() == guess.lowercased() })
    }
    
    
    struct Processor {
        let type: String
    }

    let processorOrder = ["411 ARM11","620 ARM11","600 ARM-A8","A4","A5","A6","A7","A8","A9","A10", "A11", "A12", "A13", "A14", "A15", "A16"]

    func compareProcessors(p1: Processor?, p2: Processor?) -> Int {
        guard let p1 = p1, let p2 = p2 else {
            return 0
        }
        let p1Index = processorOrder.firstIndex(of: p1.type) ?? 0
        let p2Index = processorOrder.firstIndex(of: p2.type) ?? 0

        if p1Index == p2Index {
            return 0
        } else if p1Index < p2Index {
            return -1
        } else {
            return 1
        }
    }
    
    
    
    
    
    
    var body: some View {
        
        
        NavigationView{
            
        
            ZStack {
                

                if isGameOver {
                    RelaxedGameOverView {
                        self.onResetButtonPressed()
                    }
                }
                else if isGameWonViewPresented{
                    RelaxedGameWonView{
                        self.onResetButtonPressed()
                    }
                }
                    else {
                    VStack {
                        
                        HStack{
                           
                            
                            
                            
                            Text("Phondle! Relaxed")
                                .font(Font.custom("DimboRegular", size:40))
                            
                            
                            
                        }
                        
                        
                      
                           
                        
                        TextField("Enter Guess here. . ", text: $searchText, onCommit: onEnterGuessButtonPressed)
                            .modifier(TextFieldClearButton(text: $searchText))
                            .multilineTextAlignment(.leading)
                            .padding(15)
                            .background(Color(.systemGray6))
                            .cornerRadius(30)
                            .padding(.horizontal)
                            .font(Font.custom("DimboRegular", size: 25))
                        
                            .onChange(of: searchText) { newValue in
                                if newValue.isEmpty {
                                    isListItemClicked = false
                                    
                                }
                                
                                
                                buttonText = "Enter Guess"
                                
                            }
                        
                        
                        
                        Button(action:onEnterGuessButtonPressed){
                            Text("\(buttonText)")
                                .padding(13)
                                .foregroundColor(Color.white)
                                .font(Font.custom("DimboRegular", size: 30))
                            
                            
                        }
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(15)
                        .alert("You guessed it right!", isPresented: $showingAlert) {
                            Button("Whatever", role: .cancel) { }
                        }
                        
                        
                
                        
                        
                        
                        HStack{
                            
                            VStack(alignment:.leading){
                                Text("Release Date")
                                Text("Screen Size")
                                Text("Screen Resolution")
                                Text("Processor")
                                Text("Face ID?")
                                Text("Touch ID?")
                                Text("# of Cameras")
                            }
                            .font(Font.custom("DimboRegular", size: 30))
                            .foregroundColor(Color.black)
                            
                            
                            
                            
                            Spacer()
                            VStack{
                                if let phone = selectedPhone {
                                    Text(verbatim: "\(phone.releaseYear)")
                                    Text(verbatim: "\(phone.screenSize)''")
                                    if let resolutionHeight = phone.resolutionHeight, let resolutionWidth = phone.resolutionWidth {
                                        Text(verbatim: "\(resolutionHeight)x\(resolutionWidth)")
                                        
                                    } else {
                                        Text("N/A")
                                    }
                                    Text("\(phone.processor)")
                                    if let touchID = phone.touchID {
                                        Text(touchID ? "Yes" : "No")
                                    } else {
                                        Text("N/A")
                                    }
                                    if let faceID = phone.faceID {
                                        Text(faceID ? "Yes" : "No")
                                    } else {
                                        Text("N/A")
                                    }
                                    Text("\(phone.noCameras)")
                                    
                                    
                                } else {
                                    Text("N/A")
                                    Text("N/A")
                                    Text("N/A")
                                    Text("N/A")
                                    Text("N/A")
                                    Text("N/A")
                                    Text("N/A")
                                }
                            }
                            .font(Font.custom("DimboRegular", size: 30))
                            .foregroundColor(Color.black)
                            
                            
                            
                            
                            
                            Spacer()
                            VStack{
                                if let phone = selectedPhone {
                                    Image(systemName: phone.releaseYear == answer.releaseYear ? "checkmark" : phone.releaseYear <= answer.releaseYear ? "greaterthan" : "lessthan")
                                    
                                    Image(systemName: phone.screenSize == answer.screenSize ? "checkmark" : "xmark")
                                    if let guessHeight = phone.resolutionHeight, let guessWidth = phone.resolutionWidth, let answerHeight = answer.resolutionHeight, let answerWidth = answer.resolutionWidth {
                                        Image(systemName: guessHeight == answerHeight && guessWidth == answerWidth ? "checkmark" : "xmark")
                                    } else {
                                        Image(systemName: "xmark")
                                    }
//                                    Image(systemName: phone.processor == answer.processor ? "checkmark" : "xmark")
                                    
                                    if let guessProcessor = Processor(type: phone.processor), let answerProcessor = Processor(type: answer.processor) {
                                                let comparisonResult = compareProcessors(p1: guessProcessor, p2: answerProcessor)
                                                Image(systemName: comparisonResult == 0 ? "checkmark" : comparisonResult < 0 ? "greaterthan" : "lessthan")
                                            } else {
                                                Image(systemName: "xmark")
                                            }
                                    
                                    
                                    if let guessTouchID = phone.touchID, let answerTouchID = answer.touchID {
                                        Image(systemName: guessTouchID == answerTouchID ? "checkmark" : "xmark")
                                    } else {
                                        Image(systemName: "xmark")
                                    }
                                    if let guessFaceID = phone.faceID, let answerFaceID = answer.faceID {
                                        Image(systemName: guessFaceID == answerFaceID ? "checkmark" : "xmark")
                                    } else {
                                        Image(systemName: "xmark")
                                    }
                                    Image(systemName: phone.noCameras == answer.noCameras ? "checkmark" : phone.noCameras <= answer.noCameras ? "greaterthan" : "lessthan")
                                } else {
                                    ForEach(0..<7) { _ in
                                        Image(systemName: "xmark")
                                    }
                                }
                            }
                            
                            .font(Font.custom("DimboRegular", size: 39))
                            .foregroundColor(Color.black)
                            
                            
                            
                            
                            
                        }
                        .padding()
                        
                        .cornerRadius(15)
                        
                        
                        
                        
                        Spacer()
                        
                        

                        HStack {
                            Button(action: {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Text("Back")
                                                .font(Font.custom("DimboRegular", size: 30))
                                                .background(Color.black)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                                .padding(.horizontal, 10)
                                                
                                        }
                                                
                            Text("         ")
                            NavigationLink(destination: MenuView(resetAction: self.onResetButtonPressed)) {
                            Text("Menu")
                                            .foregroundColor(Color.white)
                                                           .padding(.horizontal)
                                                   }
                                               }
                                               .font(Font.custom("DimboRegular", size:30))
                                               .padding()
                                               .background(Color.black)
                                               .foregroundColor(Color.white)
                                               .cornerRadius(30)
                        
                        
                    }
                    
                    
              
                    
                    
                    
                    
                    
                    if !searchText.isEmpty && !isListItemClicked {
                        let listHeight = 350.0
                        let searchBarHeight = CGFloat(130)
                        
                        
                        GeometryReader { geometry in
                            List(filteredData) { item in
                                Button(action: {
                                    searchText = item.name
                                    isListItemClicked = true
                                    print("item.name: \(item.name)")
                                    print("searchText: \(searchText)")
                                 
                                    
                                    
                                }) {
                                    Text(item.name)
                                        .font(Font.custom("DimboRegular", size: 25))
                                    
                                }
                            }
                            .frame(height: min(listHeight, geometry.size.height - searchBarHeight))
                            .background(Color.clear)
                            .listStyle(PlainListStyle())
                            .padding(.horizontal, 30)
                            .shadow(radius: 5)
                            .position(x: geometry.size.width / 2, y: searchBarHeight + listHeight / 2)
                            
                        }
                    }
                    
                    
                    
                }
                
                
             
                
            }
            
            
            .navigationBarTitle("", displayMode: .inline)
               .navigationBarHidden(true)
        }
        
        
        
    }
}


struct RelaxedMenuView: View {
    var resetAction: () -> Void

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        VStack {
            Text("Phondle! Menu")
                .font(Font.custom("DimboRegular", size:40))
            Spacer()
            
            
            Button(action: {
                self.resetAction()
                self.presentationMode.wrappedValue.dismiss()

            }) {
                Text("Reset")
                    .font(Font.custom("DimboRegular", size:40))
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }
            
            
            
            Spacer()
        }
    }
}


struct RelaxedGameOverView: View {
    var restartAction: () -> Void

    var body: some View {
        VStack {
            Text("Game Over!")
                .font(Font.custom("DimboRegular", size: 60))
                .foregroundColor(Color.black)
            Button(action: {
                self.restartAction()
            }) {
                Text("Restart Game")
                    .font(Font.custom("DimboRegular", size: 60))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(35)
            }
        }
    }
}

struct RelaxedGameWonView: View {
    var restartAction: () -> Void
    
    var body: some View {
        VStack {
            Text("You Won!")
                .font(Font.custom("DimboRegular", size: 60))
                .foregroundColor(Color.black)

            Button(action: {
                self.restartAction()
                
            }) {
                Text("Play Again")
                    .font(Font.custom("DimboRegular", size: 60))
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(35)
            }
            .padding()
        }
    }
}


struct RelaxedGameView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxedGameView()
    }
}
