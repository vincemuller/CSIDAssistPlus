//
//  CA_TopDashboardView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/15/24.
//

import SwiftUI

struct CA_TopDashboardView: View {
//    @StateObject var viewModel: HomeScreenViewModel
    @Binding var activeSearch: Bool
    @Binding var expandState: Bool
    @Binding var characterView: CGFloat
    @Binding var helpfulTip: String
    
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    
    //activeSearch, characterView, expandSearch, helpfulTip
    
    var body: some View {
        let height = (activeSearch ? 1.5 : screenHeight * 0.197)
        let width = screenWidth * 0.89
        let cornerRadius: CGFloat = (activeSearch ? 0 : 30)
        
        ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.caTurqBlue)
                .frame(width: width, height: height)
                .overlay(alignment: .center) {
                    Image("csidAssistLogoWhite")
                        .resizable()
                        .frame(width: 350, height: 350)
                        .rotationEffect(.degrees(25))
                        .offset(x: 110)
                        .mask {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: width, height: height)
                        }
                        .opacity(0.2)
                }
            Image("hipsterAnimal")
                .resizable()
                .frame(width: screenHeight * 0.1976, height: activeSearch ? 0 : screenHeight * 0.1976)
                .offset(x: width * 0.23, y: characterView)
                .mask {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: width, height: height)
                }
            (expandState && !activeSearch ?
             Text(helpfulTip)
                .foregroundStyle(.white)
                 .font(.custom(
                     "AmericanTypewriter",
                     fixedSize: screenHeight * 0.021))
                 .frame(width: 145)
                 .multilineTextAlignment(.center)
                 .offset(x: -85, y: screenHeight * 0.0527)
             : nil)
        }
    }
}


#Preview {
    struct Preview: View {
        @State var activeSearch = false
        @State var expandState = false
        @State var characterView = CGFloat(150)
        @State var helpfulTip = "Use filters to search off Whole Foods only"
        
        var body: some View {
            CA_TopDashboardView(activeSearch: $activeSearch, expandState: $expandState, characterView: $characterView, helpfulTip: $helpfulTip, screenWidth: 393, screenHeight: 759)
        }
    }

    return Preview()

}
