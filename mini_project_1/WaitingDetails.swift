//
//  WaitingDetails.swift
//  mini_project_1
//
//  Created by FDC-KYLE-NC-WEB on 7/29/24.
//

import SwiftUI

struct WaitingDetails: View {
    let data: [CGFloat] = [0.4, 0.6, 0.8, 3, 0.9]
    var teacher: Teacher
    var allData: [Teacher]
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    HeaderView(teacher: teacher)
                    TeacherDetailView(teacher: teacher)
                    ActionButtons()
                    TutorProfile()
                    FeatureHobbies()
                    WorkExpView()
                    BarChartView(data: data)
                    HorizontalScrollViewList(allData: allData)
                }
                .padding()
            }
        }
        
       
    }
    init(teacher: Teacher, allData: [Teacher]) {
            self.teacher = teacher
            self.allData = allData
        print(self.allData)
        }
}


struct CardView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .background(Color.blue)
                
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                HStack(spacing: 3) {
                    Image("japan")
                        .resizable()
                        .frame(width: 15, height: 10)
                    Text("Japan")
                        .foregroundStyle(.white)
                        .font(.caption2)
                }
                HStack(spacing: 3) {
                    Image(systemName: "book.closed")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                        .background(.blue)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)

                    Text("5.00")
                        .foregroundStyle(.white)
                        .font(.caption2)
                }
                HStack(spacing: 3) {
                    Image(systemName: "tv.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                    Text("96 times")
                        .foregroundStyle(.white)
                        .font(.caption2)
                }
                HStack(spacing: 3) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                    Text("127 people")
                        .foregroundStyle(.white)
                        .font(.caption2)
                }
                
            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
            Spacer()
        }
        .frame(width: 100, height: 200)
        .background(Color.customColor) // Ensure 'customColor' is defined in your extension or use a default color
        .cornerRadius(5)
    }
}

struct BarChartView: View {
    let data: [CGFloat]
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("Generation choosing this instructor")
                .foregroundStyle(.white)
                .bold()
            

            ForEach(data.indices, id: \.self) { index in
                HStack {
                    Text("Item \(index + 1)")
                        .foregroundStyle(.white)
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 10)
                            .foregroundColor(Color.gray.opacity(0.3))
                        
                        Rectangle()
                            .frame(width: self.data[index] * 20, height: 9)
                            .foregroundColor(.white)
                    }
                    Text("Item \(index + 1)")
                        .foregroundStyle(.white)
                    
                }

            }
        }
        .frame(width: 350)
        .padding(.top, 30)
        .padding(.trailing, 20)
    }
}

struct HeaderView: View {
    var teacher: Teacher
    var body: some View {
        HStack(spacing: 150) {
            HStack(spacing:15){
                Image(systemName: "pencil.circle.fill")
                    .padding(.leading, 20)
                    .foregroundStyle(.white)
                    .frame(width: 20)
                Text(teacher.title)
                    .bold()
                    .foregroundStyle(.white)
                Text("(Age: 35)")
                    .font(.caption)
                    .opacity(0.25)
            }
            
            
            Text("...")
                .bold()
                .foregroundStyle(.white)
        }

        
    }
}

struct HorizontalScrollViewList: View {
    var allData: [Teacher]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended tutors")
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(allData) { teacher in
                        CardView(title: teacher.title, imageName: teacher.imageName)
                    }
                }
            }
            .padding(.trailing, 40)
        }
        .padding(.leading, 40)
    }
}

struct WorkExpView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("work experience")
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 10)
            VStack(alignment: .leading){
                Text("2016 - 07 - 01 - Current")
                    .foregroundStyle(.white)
                    .font(.caption2)
                Text("assessment")
                    .foregroundStyle(.white)
                    .font(.caption)
                    .bold()
            }
            VStack(alignment: .leading){
                Text("2016 - 07 - 01 - 2016-06-01")
                    .foregroundStyle(.white)
                    .font(.caption2)
                Text("Teacher / Lecturer / Instructor")
                    .foregroundStyle(.white)
                    .font(.caption)
                    .bold()
            }
            VStack(alignment: .leading){
                Text("2016 - 07 - 01 - 2016-06-01")
                    .foregroundStyle(.white)
                    .font(.caption2)
                Text("Teacher / Lecturer / Instructor")
                    .foregroundStyle(.white)
                    .font(.caption)
                    .bold()
            }
            
        }.padding(.trailing, 195)

        
    }
}


struct FeatureHobbies : View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Features")
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 10)
            HStack{
                Text("Teacher who is good at free talk")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("For children")
                    .padding(5)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            HStack{
                Text("For seniors")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Grammar • vocabulary")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("pronunciation")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }.padding(.trailing, 30)
            .padding(.bottom, 30)
        
        VStack(alignment: .leading){
            Text("Hobbies")
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 10)
            HStack{
                Text("Reading")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Watching movies")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Listening to music")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            HStack{
                Text("Traveling")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Volunteering")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Cooking")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Canvas Painting")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            HStack{
                Text("Gardening")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Meditating")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Hiking")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Investment")
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .foregroundStyle(.white)
                    .font(.caption)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }.padding(.trailing, 10)
    }
}

struct TutorProfile: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Introduction")
                .foregroundStyle(.white)
                .bold()
            Text("To live is to suffer, to survive is to find meaning in suffering. (C)F. Nietzsche")
                .foregroundStyle(.white)
                .font(.caption)
                .frame(width: 280)
            Text("linebreak using br tag lorem ipsum")
                .foregroundStyle(.white)
                .font(.caption)
            Text("linebreak using br tag")
                .foregroundStyle(.white)
                .font(.caption)
            Text("Line break using enter")
                .foregroundStyle(.white)
                .font(.caption)
            Text("Personal Message")
                .foregroundStyle(.white)
                .font(.caption)
        } .padding(.trailing, 80 )
        Text("Display Transition ▼")
            .foregroundStyle(.blue)
            .font(.subheadline)
            .padding(.leading, 230)
            .padding(.top, 20)
            .padding(.bottom, 20)
        VStack(alignment: .leading, spacing: 5){
            Text("Current address")
                .bold()
                .foregroundStyle(.white)
            HStack(spacing:5){
                Image(.japan)
                    .resizable()
                    .frame(width: 15, height: 10)
                Text("Philippines • Cagayan De Oro")
                    .foregroundStyle(.white)
                    .font(.caption)
            }
            
            Text("Coins consumed")
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 10)
            
            Text("Sudden Lesson : No coins required")
                .foregroundStyle(.white)
                .font(.caption)
            Text("Booked Lesson : 100 coins")
                .foregroundStyle(.white)
                .font(.caption)
            
            
        }.padding(.trailing, 170 )
        Text("(Callan Unlimited Option : Coins Returned After The Lesson)")
            .foregroundStyle(.red)
            .font(.caption)
            .padding(.top, 2)
            .frame(width: 300)
            .padding(.trailing,100)

        
    }
}

struct TeacherDetailView: View {

    var teacher: Teacher
    var body: some View {
        HStack {
            Image(teacher.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 220, height: 380)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.leading, 30)
            
            VStack(alignment: .leading, spacing: 10) {
                flag()
                DetailRow(imageName: "rectangle.inset.filled.and.person.filled", text: "10 years 7 months")
                DetailRow(imageName: "star.fill", text: "4.97")
                DetailRow(imageName: "person.fill.questionmark", text: "5.00")
                DetailRow(imageName: "sparkles.tv.fill", text: "100537")
                DetailRow(imageName: "heart.fill", text: "130 people")
                DetailRow(imageName: "clock.fill", text: "2024-07-28 (Fri)")
                DetailRow(imageName: "person.2.circle.fill", text: "Friendly", imageSize: CGSize(width: 45, height: 45))
                DetailRow(imageName: "shared.with.you.circle.fill", text: "Explains well", imageSize: CGSize(width: 45, height: 45))
                DetailRow(imageName: "hearingdevice.ear", text: "A good listener", imageSize: CGSize(width: 45, height: 45), isCircle: true)
            }
            .padding(.trailing, 70)
        }
        .background(Color.black)
        .padding(.top, 5)
    }
}

struct flag: View {
    var body: some View {
        HStack {
            Image("japan")
                .resizable()
                .frame(width: 25, height: 19)
            Text("Japan")
                .foregroundStyle(.white)
                .font(.caption2)
        }
    }
}

struct DetailRow: View {
    let imageName: String
    let text: String
    let imageSize: CGSize
    let isCircle: Bool
    
    init(imageName: String, text: String, imageSize: CGSize = CGSize(width: 25, height: 22), isCircle: Bool = false) {
        self.imageName = imageName
        self.text = text
        self.imageSize = imageSize
        self.isCircle = isCircle
    }
    
    var body: some View {
        HStack {
            if isCircle {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: imageSize.width, height: imageSize.height)
                    
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: imageSize.width * 0.67, height: imageSize.height * 0.67)
                        .aspectRatio(contentMode: .fill)
                        .foregroundStyle(.black)
                }
            } else {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .aspectRatio(contentMode: .fill)
                    .foregroundStyle(.white)
            }
            Text(text)
                .foregroundStyle(.white)
                .font(.caption2)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
}

struct ActionButtons: View {
    var body: some View {
        VStack {
            Button("Offline") { }
                .padding(.vertical, 15)
                .padding(.horizontal, 170)
                .background(Color.gray)
                .foregroundStyle(.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.black)
                Button("Booked Lesson") { }
                    .fixedSize()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 124)
            .background(Color.white)
            .foregroundStyle(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack(spacing: 55) {
                ActionButton(icon: "heart", title: "Favorite")
                ActionButton(icon: "arrow.clockwise", title: "Refresh")
                ActionButton(icon: "paperplane", title: "Share")
                ActionButton(icon: "note.text", title: "Keep Note")
            }
            .padding(.top, 10)
            
            HStack(spacing: 50) {
                FooterButton(title: "Tutor's Profile", isActive: true)
                FooterButton(title: "Lesson Detail", isActive: false)
                FooterButton(title: "Reviews", isActive: false)
            }
            .padding()
            .padding(.top, 10)
        }
        .padding(.top, 20)
    }
}

struct ActionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .bold()
            Text(title)
                .foregroundStyle(.white)
                .font(.caption2)
        }
    }
}

struct FooterButton: View {
    let title: String
    let isActive: Bool
    
    var body: some View {
        Text(title)
            .foregroundStyle(isActive ? .white : .white.opacity(0.7))
            .font(.subheadline)
            .overlay(
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: 2)
                    .offset(y: 10)
                    .opacity(isActive ? 1 : 0)
                , alignment: .bottom
            )
    }
}
extension Color {
    static let customColor = Color(red: 48/255, green: 44/255, blue: 44/255)}
    

#Preview {
    WaitingDetails(teacher: Teacher(title: "John Doe", imageName: "bini"), allData: [
        Teacher(title: "John Doe", imageName: "bini"),
        Teacher(title: "Jane Smith", imageName: "jane"),
    ])
}
