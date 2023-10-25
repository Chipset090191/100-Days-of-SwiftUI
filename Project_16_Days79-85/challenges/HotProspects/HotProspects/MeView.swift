//
//  MeView.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 27.08.2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Mikhail Tikhomirov"
    @State private var emailAddress = "Chipset@mail.ru"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
//                    .textContentType(.name)
                    .font(.title)
                
                TextField ("Email address", text: $emailAddress)
//                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none) // to avoid bluring of our QR-Code
                    .scaledToFit()
                    .frame(width:200, height: 200)
                    .contextMenu{
                        Button {
                            // save my code
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        }label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your code")
            .onAppear{
                updateCode()
            }
            .onChange(of: name) { _ in
                updateCode()
            }
            .onChange(of: emailAddress) { newValue in
                updateCode()
            }
        }
    }
    
    func updateCode() {
          qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    // this func for generating our QRCode
    func generateQRCode(from string:String) -> UIImage {
        filter.message = Data(string.utf8)              // convert our String to a Data object, it helps us generate new qr again and again
        
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
                
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
