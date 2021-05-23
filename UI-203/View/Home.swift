//
//  Home.swift
//  UI-203
//
//  Created by にゃんにゃん丸 on 2021/05/23.
//

import SwiftUI

extension View{
    
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

struct Home: View {
      @State var startAnimation = false
    @State var startCardRote = false
    @State var cardAnimation = false
    @Namespace var animation
    
    @State var selectedcard : Card = Card(cardHolder: "", cardNumber: "", cardImage: "", cardValidty: "")
    
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            
            
            VStack{
                
                
                
                HStack{
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                        
                        Text("Welcom Back")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                    })
                    
                    Spacer(minLength: 0)
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "gear")
                            .font(.title)
                        
                        
                    })
                    
                    
                    
                }
                .foregroundColor(.green)
                
                
                ZStack{
                    
                    ForEach(cards.indices.reversed(),id:\.self){index in
                        
                        
                        CardView(card: cards[index])
                         .scaleEffect(selectedcard.id == cards[index].id ? 1 : index == 0 ? 1 : 0.9)
                            
                    
                            
                            
                            .rotationEffect(.init(degrees:startAnimation ? 0 : index == 1 ? -15 : (index == 2 ? 15 : 0)))
                            .onTapGesture {
                                AnimationView(card: cards[index])
                            }
                           
                            
                            
                            
                            
                            
                            .offset(y:startAnimation ? 0 : index == 1 ? 60 : (index == 2 ? -60 : 0))
                            
                            .matchedGeometryEffect(id: "CARD_ANIMATIO", in: animation)
                            
                            
                            
                            .rotationEffect(.init(degrees:selectedcard.id == cards[index].id && startCardRote ? -90 : 0))
                        
                            .zIndex(selectedcard.id == cards[index].id ? 1000 : 0)
                            .opacity(startAnimation ? selectedcard.id == cards[index].id ? 1 : 0 : 1)
                        
                        
                        
                    }
                    
                
                    
                }
               .rotationEffect(.init(degrees: 90))
                .frame(width: getRect().width - 30)
                .padding(.top,50)
                .scaleEffect(0.8)
                
                
                VStack(alignment: .leading, spacing: 15, content: {
                    Text("Total Amount")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue)
                        .frame(height:0.5)
                    
                    Text("$155.155.1555")
                        .font(.system(size: 30, weight: .ultraLight))
                        .font(.headline)
                       
                    
                })
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.top,30)
                
                
                
                
            
                
            }
            .padding()
            
           
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.3).ignoresSafeArea())
        .blur(radius: cardAnimation ? 100 : 0)
        .overlay(



            ZStack(alignment:.topTrailing,content:{

                if cardAnimation{


                    Button(action: {

                        withAnimation(.interactiveSpring(response: 2, dampingFraction: 2, blendDuration: 2)){
                            
                            startAnimation = false
                            selectedcard = Card(cardHolder: "", cardNumber: "", cardImage: "", cardValidty: "")
                            cardAnimation = false
                        startCardRote = false
                        }


                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(scheme == .dark ? .black : .white)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    })
                    .padding()

                    CardView(card: selectedcard)
                        .matchedGeometryEffect(id: "CARD_ANIMATIO", in: animation)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            })


        )

    }
    
    func AnimationView(card : Card){
        
        
        
        if selectedcard.cardNumber == "" {
            
            selectedcard = card
               
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.4)){
                   
                   
                   startAnimation = true
               }
               
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                 
                   
                   withAnimation(.spring()){
                       
                       startCardRote = true
                    
                  
                       
                       
                   }
                   
                   
               }
               
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                 
                   
                   withAnimation(.spring()){
                       
                     
                       cardAnimation = true
                   
                       
                   }
                   
                   
               }
        }
        
        
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
struct CardView : View {
    
    var card : Card
    var body: some View{
        
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
            .overlay(
                VStack(alignment: .leading, spacing: 15, content: {
                    
                    Spacer()
                    
                    Text(card.cardNumber)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading,10)
                    
                    Spacer()
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            
                            
                            Text("CARD HOLDER")
                                .font(.title2)
                                .fontWeight(.semibold)
                                
                            
                            Text(card.cardHolder)
                                .font(.footnote)
                                .fontWeight(.bold)
                            
                            
                            
                        })
                        .foregroundColor(.blue)
                        
                        
                        
                        
                        Spacer(minLength: 0)
                        
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            
                            
                            Text("CARD Validty")
                                .font(.title2)
                                .fontWeight(.semibold)
                                
                            
                            Text(card.cardValidty)
                                .font(.footnote)
                                .fontWeight(.bold)
                            
                            
                            
                        })
                        .foregroundColor(.white)
                       
                        
                        
                    }
                
                    .padding([.horizontal,.bottom])
                    
                    
                    
                    
                })
            
            )
    
        
    }
}

