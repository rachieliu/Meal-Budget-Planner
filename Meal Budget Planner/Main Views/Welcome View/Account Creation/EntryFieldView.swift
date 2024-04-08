import SwiftUI

struct EntryFieldView: View {
   
    let title: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            HStack {
                
                
                
                if isSecure {
                    SecureField(placeholder, text: $field)
                        .font(.system(size: 14))
                        
                } else {
                    TextField(placeholder, text: $field)
                        .font(.system(size: 14))
                }
            }.autocapitalization(.none)
            .padding(8)
            .background(Color(.white))
            .cornerRadius(10)
            Divider()
           
            
            Text(prompt)
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size:10))
                .foregroundColor(.gray)
                
        }
    }
}

struct EntryFieldView_Previews: PreviewProvider {
    static var previews: some View {
        EntryFieldView(title: "Email Address",placeholder: "name@example.com", prompt: "Enter a valid email address", field: .constant(""))
    }
}
