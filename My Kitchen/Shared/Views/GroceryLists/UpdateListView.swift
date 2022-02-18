//
//  UpdateListView.swift
//  My Kitchen
//
//  Created by Rishik Dev on 31/01/22.
//

import SwiftUI

struct UpdateListView: View
{
    @Environment(\.presentationMode) var presentationMode   // to go back to the list view upon pressing save button
    
    @StateObject var groceryListViewModel: GroceryListViewModel
    @State var groceryListEntity: GroceryListEntity
        
    @State var listTitle: String
    @State var listContent: String
    let textEditorPlaceholder: String = "Start your list from here..."
    
    var body: some View
    {
        VStack()
        {
            TextField("Enter Title...", text: $listTitle)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            
            Divider()
            
            CustomTextEditorUpdateList.init(placeholder: textEditorPlaceholder, listContent: $listContent)
        }
        .padding()
//        .navigationTitle(listTitle.count >= 10 ? listTitle.prefix(10) + "..." : listTitle)
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Button(action: saveButtonPressed)
                {
                    Text("Save")
                }
                .disabled(textIsAppropriate() ? false : true)
            }
        }
    }
    
    func saveButtonPressed()
    {
        if textIsAppropriate()
        {
            groceryListEntity.listTitle = listTitle
            groceryListEntity.listContent = listContent
            groceryListViewModel.updateItem()
            presentationMode.wrappedValue.dismiss() // go back one step in the view hierarchy
        }
    }

    func textIsAppropriate() -> Bool
    {
        if listTitle.count == 0 && listContent.count == 0
        {
            return false
        }

        else
        {
            return true
        }
    }
}

struct CustomTextEditorUpdateList: View
{
    let placeholder: String
    @Binding var listContent: String
    
    var body: some View
    {
        ZStack(alignment: .topLeading)
        {
            if listContent.isEmpty
            {
                Text(placeholder)
                    .foregroundColor(.primary.opacity(0.25))
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(5)
            }
            
            TextEditor(text: $listContent)
                .padding(5)
        }
        .onAppear()
        {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear()
        {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

struct UpdateListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            UpdateListView(groceryListViewModel: GroceryListViewModel(), groceryListEntity: GroceryListEntity(), listTitle: "", listContent: "")
        }
    }
}
