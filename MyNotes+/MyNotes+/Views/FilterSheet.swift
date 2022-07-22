//
//  FilterModal.swift
//  My Notes
//
//  Created by Rishik Dev on 19/03/22.
//

import SwiftUI

struct FilterSheet: View
{
    @Environment(\.colorScheme) var colourScheme
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var quickSettings: QuickSettingsClass
    
    var body: some View
    {
        VStack
        {
            #if !os(watchOS)
            HStack
            {
                Button(action: { dismiss() })
                {
                    Text("Cancel")
                }
                .padding(.leading, 10)
                .padding(.top, 10)
                
                Spacer()
            }
            #endif
            
            Form
            {
                Section(header: Text("Select Filter"))
                {
                    List
                    {
                        ForEach(["🔴 Red", "🟢 Green", "🔵 Blue", "🟡 Yellow", "⚪️ White"], id: \.self)
                        {
                            buttonText in
                            
                            Button(action: {
                                quickSettings.currentFilter = String(buttonText.split(separator: " ")[0])
                                dismiss()
                            })
                            {
                                HStack
                                {
                                    Text(buttonText)
                                    Spacer()
                                    
                                    if(quickSettings.currentFilter == String(buttonText.split(separator: " ")[0]))
                                    {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                                      
                        Button(action: {
                            quickSettings.currentFilter = "🔴🟢🔵🟡⚪️"
                            dismiss()
                        })
                        {
                            HStack
                            {
                                Text("Show All")
                                
                                Spacer()
                                
                                if(quickSettings.currentFilter == "🔴🟢🔵🟡⚪️")
                                {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .foregroundColor(colourScheme == .light ? .black : .white)
        }
    }
}

struct FilterSheet_Previews: PreviewProvider
{
    static var previews: some View
    {
        FilterSheet(quickSettings: QuickSettingsClass())
    }
}
