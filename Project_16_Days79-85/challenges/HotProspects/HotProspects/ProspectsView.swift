//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Михаил Тихомиров on 27.08.2023.
//
import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortEn {
        case Asc, Desc, Earliest, Latest
    }
    
    // this @EnvironmentObject - it finds the prospects class in the environment, attach it to our local "prospects" property, wait if it changes and automatically reinvoke the body property 
    @EnvironmentObject var prospects:Prospects   // ! remember you need to have an instance of Prospects somewhere in your app
    
    @State private var isShowingScanner = false
    @State private var showingFilterSheet = false
    
    @State private var sorten:SortEn = .Asc         // for sorting
    
    let filter:FilterType
    
    

    
    
    
    var title:String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{ $0.isContacted }
        case .uncontacted:
            return prospects.people.filter{ !$0.isContacted }
        }
    }
    
    var filteredAndSorted: [Prospect] {
        switch sorten {
        case .Asc:
            return filteredProspects.sorted { $0.name < $1.name }
        case .Desc:
            return filteredProspects.sorted { $0.name > $1.name }
        case .Earliest:
            return filteredProspects.sorted { $0.date < $1.date }
        case .Latest:
            return filteredProspects.sorted { $0.date > $1.date }
        }
    }
    
    
    
    
    
    var body: some View {
        NavigationView {
            List  {
                ForEach(filteredAndSorted) { prospect in
                    VStack(alignment: .leading) {
                        HStack{
                            VStack(alignment: .leading){
                                Text(prospect.name)
                                    .font(.headline)
                                Text(prospect.emailAdress)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            
                            VStack(alignment: .trailing){

                                MarksView(isContacted: prospect.isContacted)
                            }
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                
                                // indtead of prospect.isContacted.toggle() we use string below
                                prospects.toggle(prospect)
                                
                            }label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                
                                  prospects.toggle(prospect)
                                
//                                prospect.isContacted.toggle()
                            }label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
                .navigationTitle(title)
                .confirmationDialog("Select a sort order ", isPresented: $showingFilterSheet) {
                    Button ("Ascending order") {
                        sorten = .Asc
                    }
                    Button ("Descending order") {
                        sorten = .Desc
                    }
                    Button ("The earliest user") {
                        sorten = .Earliest
                    }
                    Button ("The latest user") {
                        sorten  = .Latest
                    }
                }
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showingFilterSheet = true
                        }label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingScanner = true
                        }label: {
                            Label("Scan", systemImage: "qrcode.viewfinder")
                        }
                    }
                    
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            
            let person = Prospect()
            person.name = details[0]
            person.emailAdress = details[1]
            person.date = Date.now
//            prospects.people.append(person)
//            prospects.save()
            // so instead of two lines of code above we must write down
            prospects.add(person)
            
        case .failure(let error):
            print ("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAdress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // that`s for test. call noti after 5 sec now // that was for testing
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()  // we call our closure here at this point that looks like () - > Void
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print ("not successful")
                    }
                }
            }
        }
        
    }

    
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
