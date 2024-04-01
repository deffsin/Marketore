//
//  ProductInfoView.swift
//  Marketore
//
//  Created by Denis Sinitsa on 10.02.2024.
//

import SwiftUI

struct ProductInfoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProductInfoViewModel
    @EnvironmentObject var appState: AppState
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            buildMainContent()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func buildMainContent() -> some View {
        ZStack {
            Color(appColor: .darkBackgroundColor)
                .ignoresSafeArea(.all)
            
            HStack {
                Spacer()
                VStack {
                    header()
                        .padding([.horizontal, .vertical], 10)
                                        
                    VStack(spacing: 15) {
                        textFields()
                        
                        tagsLayout()
                        
                    }
                    
                    imagePickerButton()
                    
                    if viewModel.selectedImage != nil {
                        imageView()
                    }
                                                            
                    styledButton()
                        .padding(.top, 70)
                    
                    Spacer()
                }
                .overlay {
                    Group {
                        if viewModel.isShowingSnackBar {
                            SnackBar(isShowing: $viewModel.isShowingSnackBar, message: viewModel.messageToUser!)
                                .onAppear(perform: viewModel.startSnackBarTimer)
                                .offset(y: 300)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 50)
            .animation(.easeInOut, value: isShowing)
            .overlay {
                customNavBar()
            }
            .onChange(of: viewModel.isShowingSnackBar) {
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        isShowing = false
                    }
                }
            }
            .onChange(of: viewModel.isButton) {
                if viewModel.isButton {
                    appState.isAddProductFullScreenCoverShown = false
                }
            }
            .onChange(of: viewModel.priceString) { newValue in
                viewModel.convertPrice(priceString: newValue)
            }
        }
        .sheet(isPresented: $viewModel.isPickerShowing, onDismiss: nil) {
            ImagePicker(selectedImage: $viewModel.selectedImage)
        }
    }
    
    func customNavBar() -> some View {
        return ZStack {
            Group {
                Color(appColor: .darkGrayColor)
            }
            .ignoresSafeArea(.all)
            
            HStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                            Spacer()
                        }
                    }
                }
                .font(.system(size: 17))
                .foregroundStyle(.white)
                .padding(.horizontal, 1)
                
                Spacer()
            }
            .font(.title)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .frame(height: 35)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func header() -> some View {
        HStack {
            headerItem(isActive: true)
            headerItem(isActive: true)
            headerItem(isActive: true)
        }
    }

    func headerItem(isActive: Bool = false) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 35, height: 8)
            .foregroundColor(isActive ? .white : .gray.opacity(0.5))
    }
    
    func textFields() -> some View {
        VStack(spacing: 15) {
            InputField(text: $viewModel.title, title: "Title:", keyboardType: .alphabet)
            textEditor()
            InputField(text: $viewModel.location, title: "Location:", keyboardType: .alphabet)
            InputField(text: $viewModel.contact, title: "Contact", keyboardType: .alphabet)
            InputField(text: $viewModel.priceString, title: "Price")
        }
    }
    
    func textEditor() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 2) {
                Text("Description:")
                    .font(.system(size: 14))
                Text("(optional)")
                    .font(.system(size: 10))
                    .opacity(0.7)
            }
            .bold()
            .foregroundStyle(.white)
            
            TextEditor(text: $viewModel.description)
                .scrollContentBackground(.hidden)
                .foregroundStyle(.black)
                .background(.white)
                .frame(width: 270, height: 70)
                .cornerRadius(8)
        }
        .font(.system(size: 14))
    }
    
    func tagsLayout() -> some View {
        VStack(spacing: 5) {
            Text("Tags:")
                .font(.system(size: 14))
                .bold()
                .foregroundColor(.white)
            
            TagLayout(alignment: .center, spacing: 10) {
                ForEach(viewModel.allData, id: \.self) { tag in
                    tagView(tag)
                }
            }
        }
    }
    
    func tagView(_ tag: String) -> some View {
        HStack(spacing: 10) {
            Text(tag)
                .font(.callout)
                .fontWeight(.semibold)
        }
        .frame(height: 35)
        .foregroundStyle(.white)
        .padding(.horizontal, 15)
        .background {
            Capsule()
                .fill(Color(appColor: .purpleColor))
        }
    }
    
    func imagePickerButton() -> some View {
        Button(action: {
            viewModel.isPickerShowing.toggle()
        }) {
            Text("Select image")
                .font(.system(size: 15))
        }
    }
    
    func imageView() -> some View {
        Image(uiImage: viewModel.selectedImage!)
            .resizable()
            .frame(width: 50, height: 50)
    }
    
    func styledButton() -> some View {
        Button(action: {
            Task {
                await viewModel.saveData()
            }
        }) {
            Text("Add")
                .frame(width: 100, height: 50)
                .foregroundStyle(.white)
                .background(.green)
                .cornerRadius(15)
        }
    }
}

#Preview {
    ProductInfoView(viewModel: ProductInfoViewModel(), isShowing: .constant(false))
}
