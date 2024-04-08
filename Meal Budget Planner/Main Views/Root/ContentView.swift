import SwiftUI


struct ContentView: View {
    var body: some View {
        WelcomeView()
    }
}


struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}


