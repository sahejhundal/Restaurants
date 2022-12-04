import SwiftUI

struct AddDishView: View {
    @ObservedObject var vm : AddDishViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                
                InputTextField(text: $vm.dish.name, placeholder: "Name", keyboardType: .namePhonePad, sfSymbol: "paragraphsign")
                InputTextField(text: $vm.dish.codename, placeholder: "Codename", keyboardType: .namePhonePad, sfSymbol: "key").disableAutocorrection(true)
                InputFloatField(text: $vm.dish.price, placeholder: "Price", keyboardType: .numbersAndPunctuation, sfSymbol: "dollarsign.circle")
                InputTextEditor(text: $vm.dish.description, placeholder: "Description", keyboardType: .namePhonePad, sfSymbol: "note.text")
                
                Text("Nutrition (g)").fontWeight(.bold).padding(.top,15)
                HStack{
                    InputIntField(text: $vm.dish.protein, placeholder: "Protein", keyboardType: .numbersAndPunctuation, sfSymbol: "p.square.fill")
                    InputIntField(text: $vm.dish.sugar, placeholder: "Sugar", keyboardType: .numbersAndPunctuation, sfSymbol: "s.square.fill")
                    InputIntField(text: $vm.dish.fat, placeholder: "Fat", keyboardType: .numbersAndPunctuation, sfSymbol: "f.square.fill")
                }
                Toggle("Vegan", isOn: $vm.dish.vegan)
                    .padding()
                    .background(
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .stroke(Color.gray.opacity(0.25))
                        }
                    )
                    .padding(.vertical)
                ButtonComponentView(title: "Add Dish") {
                    vm.addDish()
                    vm.showMenuBuilder.toggle()
                }
            }
            .padding()
            .navigationBarTitle("Add Dish")
            .applyClose()
        }
    }
}



struct AddDishView_Previews: PreviewProvider {
    static var previews: some View {
        AddDishView(vm: AddDishViewModel())
    }
}
