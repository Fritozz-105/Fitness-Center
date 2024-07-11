import SwiftUI

struct WorkoutView: View 
{
    @State private var currentDate: Date = .init()
    @State private var weekView: [[Date.Weekday]] = []
    @State private var currentDayInWeek: Int = 1
    @State private var createNewWeek: Bool = false
    @State private var addExercise: Bool = false
    
    @Namespace private var animation
    
    var body: some View
    {
        ContentHeaderView(title: "Track a Workout",
                          subtitle: "",
                          bar1: Color.pink)
        .frame(width: UIScreen.main.bounds.width * 2, height: 100)
            
        VStack(alignment: .leading, spacing: 0, content: {
            DateView()
            
            ScrollView(.vertical)
            {
                VStack
                {
                    ExercisesView(currentDate: $currentDate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: { addExercise.toggle() }, label: {
                Image(systemName: "plus")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 55, height: 55)
                    .background(.red.shadow(.drop(color: .black.opacity(0.25),  radius: 5, x: 10, y: 10)), in: .circle)
            })
            .padding(15)
        })
        .onAppear(perform: {
            if weekView.isEmpty
            {
                let currentWeek = Date().getWeek()
                if let firstDate = currentWeek.first?.date
                {
                    weekView.append(firstDate.createPreviousWeek())
                }
                weekView.append(currentWeek)
                if let lastDate = currentWeek.last?.date
                {
                    weekView.append(lastDate.createNextWeek())
                }
            }
        })
        .sheet(isPresented: $addExercise, content: {
            AddExerciseView()
                .presentationDetents([.height(375)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
                .presentationBackground(.background)
        })
    }
    
    @ViewBuilder
    func DateView() -> some View
    {
        VStack(alignment: .leading, spacing: 6)
        {
            HStack(spacing: 5)
            {
                Text(currentDate.format("MMMM"))
                    .foregroundColor(Color.blue)
                
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(Color.gray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
                
            TabView(selection: $currentDayInWeek)
            {
                ForEach(weekView.indices, id: \.self) { index in
                    let week = weekView[index]
                    WeekView(week)
                        .padding(.horizontal, 15)
                        .tag(index)
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .hSpacing(.leading)
        .padding(15)
        .onChange(of: currentDayInWeek, initial: false) { oldValue, newValue in
            if newValue == 0 || newValue == (weekView.count - 1)
            {
                createNewWeek = true
            }
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.Weekday]) -> some View
    {
        HStack(spacing: 0)
        {
            ForEach(week, id: \.id) { day in
                VStack(spacing: 8)
                {
                    Text(day.date.format("E"))
                        .foregroundColor(Color.black)
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .foregroundColor(Color.black)
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                        .frame(width: 35, height: 35)
                        .background(content: {
                            if isSameDate(day.date, currentDate)
                            {
                                Circle()
                                    .fill(Color.red)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            if day.date.isToday
                            {
                                Circle()
                                    .fill(Color.cyan)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing(.center)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background
        {
            GeometryReader
            {
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 15 && createNewWeek
                        {
                            extendWeek()
                            createNewWeek = false
                        }
                    }
            }
        }
    }
    
    func extendWeek()
    {
        if weekView.indices.contains(currentDayInWeek)
        {
            if let firstDate = weekView[currentDayInWeek].first?.date, currentDayInWeek == 0
            {
                weekView.insert(firstDate.createPreviousWeek(), at: 0)
                weekView.removeLast()
                currentDayInWeek = 1
            }
            if let lastDate = weekView[currentDayInWeek].last?.date, currentDayInWeek == weekView.count - 1
            {
                weekView.append(lastDate.createNextWeek())
                weekView.removeFirst()
                currentDayInWeek = weekView.count - 2
            }
        }
    }
}

#Preview
{
    WorkoutView()
}
