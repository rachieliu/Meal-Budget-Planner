import SwiftUI
import Combine

struct EntryFieldView: View {
   
    let title: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    @State private var isExpanded = false
    
    let symbolPredicate = NSPredicate(format: "SELF MATCHES %@", "^[^<>&\"]*$") // Predicate to check for invalid symbols
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(title)
                    .foregroundColor(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .padding(.leading)
                Spacer()
                // DisclosureGroup for expanding/ compressing help message
                if title == "Email" || title == "Password" || title == "Name" || title == "Confirm Password"{
                    DisclosureGroup(
                        isExpanded: $isExpanded,
                        content: {
                            Text(prompt)
                                .font(.system(size:10))
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.trailing)
                            //.padding(.trailing)
                        },
                        label: {
                            Image(systemName: isExpanded ? "info.circle" : "info.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 9, height: 9)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    )
                }
            }
            
            
            HStack {
                
                
                
                if isSecure {
                    SecureField(placeholder, text: $field)
                        .font(.system(size: 14))
                        .onReceive(Just(field)) { newValue in
                            let filtered = newValue.filter { symbolPredicate.evaluate(with: String($0)) }
                            if filtered != newValue {
                                field = filtered
                            }
                        }
                        
                } else {
                    TextField(placeholder, text: $field)
                        .font(.system(size: 14))
                        .onReceive(Just(field)) { newValue in
                            let filtered = newValue.filter { symbolPredicate.evaluate(with: String($0)) }
                            if filtered != newValue {
                                field = filtered
                            }
                        }
                }
            }.autocapitalization(.none)
            .padding(8)
            .background(Color(.white))
            .cornerRadius(10)
            Divider()
           
            
            
                
        }
        .onTapGesture {
            // Toggle expansion state on tap
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}

struct EntryFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFieldView(title: "Email Address",placeholder: "name@example.com", prompt: "Enter a valid email address", field: .constant(""))
    }
}
