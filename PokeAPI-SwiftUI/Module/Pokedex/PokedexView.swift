//
//  PokedexView.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import SwiftUI

struct PokedexView: View {
    
    @StateObject var viewModel = PokedexViewModel()
    @State private var buttonFrame: CGRect = .zero
    @State private var selectedPokemon: Int?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            ColorUtils.primary
                .ignoresSafeArea(edges: .all)
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Image("pokeball")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .foregroundColor(ColorUtils.white)
                    Text("Pokedex")
                        .font(FontUtils.headerHeadline)
                        .foregroundColor(ColorUtils.white)
                    Spacer()
                }
                .padding(.leading, 16)
                
                HStack(spacing: 0) {
                    SearchBoxComponent(text: $viewModel.searchText)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                    SortButtonComponent(isSorted: .constant(false), buttonFrame: $buttonFrame) {
                        viewModel.showSortMenu.toggle()
                    }
                    .padding(.trailing, 16)
                }
                
                NavigationLink(
                    destination: Group {
                        if let index = selectedPokemon {
                            PokemonView(
                                viewModel: PokemonViewModel(
                                    selectedPokemon: index,
                                    pokedex: viewModel.pokemons
                                )
                            )
                        }
                    },
                    isActive: Binding(
                        get: { selectedPokemon != nil },
                        set: { if !$0 { selectedPokemon = nil } }
                    )
                ) {
                    EmptyView()
                }
                .hidden()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(ColorUtils.white)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(Array(viewModel.filteredPokemons.enumerated()), id: \.1.id) { index, item in
                                Button {
                                    selectedPokemon = index
                                } label: {
                                    PokemonCardComponent(
                                        name: item.name,
                                        imageURL: item.imageURL,
                                        idTag: item.id ?? ""
                                    )
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding(8)
            }
        }
        .overlay(
            Group {
                if viewModel.showSortMenu {
                    VStack(alignment: .trailing, spacing: 0) {
                        Spacer().frame(height: buttonFrame.origin.y)
                        SortComponent(selectedOption: $viewModel.selectedOption)
                            .shadow(radius: 4)
                        Spacer()
                    }
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.showSortMenu)
                }
            }
        )
    }
}

struct ButtonFrameKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(viewModel:  {
            let vm = MockPokedexViewModel()
            vm.fetchPokedex()
            return vm
        }())
    }
}
