//
//  logExpense.swift
//  Spendlllly
//
//  Created by Halah Aldekhiel on 22/01/1445 AH.
//
import SwiftUI

//step 1 -- Create a shape view which can give shape
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//step 2 - embed shape in viewModifier to help use with ease
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
//step 3 - crate a polymorphic view with same name as swiftUI's cornerRadius
extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}





struct logExpense: View {
    @Environment(\.managedObjectContext) private var moc
    //@StateObject var viewModel : WantViewModel
    @ObservedObject var viewModel : WantViewModel

    @Environment(\.presentationMode) var presentationMode
    let dateFormatter = DateFormatter()
   
    
    static let ourBlue = Color(hex: "5AA5E2")
    let ourBlue = Color(red: 0.35294117647058826, green: 0.6470588235294118, blue: 0.8862745098039215)
    @State var pickerSelection = 0
    
   
    @State var addSubtract = "add"
    @State var total = 0
    @State var selectedCategory = "Need"
    let categories = ["Need","Want","Savings"]
    let items = ["None","Housing","Transportation","Food","Medicine","Insurance","Clothing","Leisure","Personal"]
    @State var selectedItem = "None"
    var body: some View {
        ZStack{
            Color(hex: "5AA5E2")
            
            VStack {
                Spacer().frame(height:200)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.white)
                    .frame(width: 390, height: 800, alignment: .bottomTrailing)
                    .padding(.top, 30.0)
                
        
            }
            
            
            VStack(alignment: .leading, spacing: 20){
               
                
                HStack {
                    Spacer().frame(width:115)
                    Text("Log Expenses")
                        .foregroundColor(.white)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20.0)
                    
                }
                Spacer().frame(height:3)
                VStack{
                    Form{
                        
                        Picker(selection: $addSubtract, label: Text("add or subtract picker")) {
                            Text("Add Balance").tag("add")
                            Text("Subtract Balance").tag("subtract")
                        }
                        .frame(width: 280.0, height: 58.0)
                        .pickerStyle(SegmentedPickerStyle())
                        
                        
                        
                        HStack {
                                Text("SAR")
                                                      
                                TextField("Enter Sum Here", value: $total, format: .currency(code: ""))
                                 .font(.body)
                                 .keyboardType(.decimalPad)
                            Spacer().frame(width:23)
                        }
                        
                        
                        
                        Picker(selection: $selectedCategory, label: Text("Choose category")
                            .multilineTextAlignment(.leading)) {
                                ForEach(categories, id: \.self){
                                    cat in Text(cat)
                                }
                            }.padding([.top, .trailing]).frame(width: 290.0)
                        
                        
                        
                        Picker(selection: $selectedItem, label: Text("Selected Item")
                            .multilineTextAlignment(.leading)) {
                                ForEach(items, id: \.self){
                                    it in Text(it)
                                }
                            }.padding(.top).frame(width: 280.0)
                       

                        Button("Confirm") {
                            
                            if addSubtract == "subtract" {
                                total = -total
                            }
                            viewModel.addDataToCoreData(name: selectedItem, amount: Double(total),category:selectedCategory)
                           
                            
                        }
                        .frame(width: 260.0, height: 38.0)
                        .background(Color(hex: "5AA5E2"))
                        .foregroundColor(.white)
                        .cornerRadius(22)
                        .padding([.top, .leading, .trailing], 50.0)
                        
                        Spacer()}.background(Color.white)
                        .padding()
                        .scrollContentBackground(.hidden)
                        .frame(height:660.0)
                //end of frame
                
                
            }//end of vstack1
            
            
        }//end of vstack0
        
    }.ignoresSafeArea()//end of zstack
      
    }//end of body
}//end of struct

struct logExpenses_Previews: PreviewProvider {
    static var previews: some View {
        logExpense(viewModel: WantViewModel())
    }
}
