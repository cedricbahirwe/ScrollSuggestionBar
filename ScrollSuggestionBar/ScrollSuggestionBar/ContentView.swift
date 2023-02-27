//
//  ContentView.swift
//  ScrollSuggestionBar
//
//  Created by Cédric Bahirwe on 27/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State var container = SuggestionContainer(keys: Set(phrases))

    var body: some View {
        VStack {
            List {
                ForEach(phrases, id:\.self) { item in
                    Text(item)
                }
            }
            .listSuggestions(container) { _ in }
            .listStyle(.grouped)
//            .frame(height: 200)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension List {
    func listSuggestions(_ container: SuggestionContainer, match: @escaping (AnyHashable?) -> Void) -> some View {
        ModifiedContent(content: self, modifier: ListViewModifier(container: container, match: match))
    }

    func scrollSuggestions(_ container: SuggestionContainer, match: @escaping (AnyHashable?) -> Void) -> some View {
        ModifiedContent(content: self, modifier: ListViewModifier(container: container, match: match))
    }
}


private let phrases = [
    "After the long day, I need to take an afternoon nap.",
    "All the students in the class were eager to participate in the discussion.",
    "Alice was always curious about what was happening in the world around her.",
    "Art museums are some of the best places to learn about history and culture.",
    "Being able to play a musical instrument is a great skill to have.",
    "Basketball is one of the most popular sports in the world.",
    "Birds are some of the most fascinating creatures in nature.",
    "Baking a cake from scratch can be a fun and rewarding experience.",
    "Cooking is one of my favorite hobbies.",
    "Cats are known for their independence and their ability to be great companions.",
    "Children love to play and explore the world around them.",
    "Climbing mountains can be a challenging but exhilarating experience.",
    "Dogs are often referred to as man's best friend.",
    "Drawing is a great way to express yourself creatively.",
    "Dancing is a fun way to get exercise and improve your coordination.",
    "Driving on a scenic route can be a great way to enjoy the beauty of nature.",
    "Eating healthy and staying active is important for maintaining good health.",
    "Elephants are one of the largest land animals on Earth.",
    "Exploring new cultures and traditions can be a great way to broaden your horizons.",
    "Engaging in meaningful conversations can help build strong relationships.",
    "Family is the most important thing in life.",
    "Friends are the people who make life more fun and interesting.",
    "Fishing is a great way to spend a relaxing day outdoors.",
    "Fitness is an important aspect of overall health and well-being.",
    "Gardening is a great way to connect with nature and grow your own food.",
    "Gratitude is the key to a happy and fulfilling life.",
    "Games are a fun way to challenge your mind and keep yourself entertained.",
    "Giving back to your community is a great way to make a positive impact on the.",
    "Happiness is a state of mind that comes from within.",
    "Hiking is a great way to explore nature and get some exercise.",
    "Helping others can bring a sense of fulfillment and purpose to your life.",
    "History is a fascinating subject that can help us understand the world we live",
    "Insects play an important role in the ecosystem.",
    "Imagination is the key to creativity and innovation.",
    "Investing in yourself is the best investment you can make.",
    "Integrity is a fundamental value that should guide your actions and decisions.",
    "Jazz music is a uniquely American art form.",
    "Joy is a feeling of happiness and contentment that comes from within.",
    "Juggling is a fun and challenging activity that can improve your hand-eye",
    "Journaling is a great way to reflect on your thoughts and feelings and keep track",
    "Kindness is a powerful force that can make a big difference in the world.",
    "Knowledge is the foundation of wisdom and understanding.",
    "Kites are a fun way to spend a sunny afternoon in the park.",
    "Karaoke is a fun way to let loose and have some fun with friends.",
    "Love is the most powerful emotion in the world.",
    "Learning new things is a great way to keep your mind active and engaged.",
    "Laughter is the best medicine for stress and anxiety.",
    "Listening to music can help improve your mood and reduce stress.",
    "Music is a universal language that can bring people together.",
    "Meditation is a great way to reduce stress and improve your overall well-being.",
    "Mindfulness is the practice of being present in the moment and fully engaged in your surroundings.",
    "Mountains are some of the most beautiful natural wonders on Earth.",
    "Nature is a source of inspiration and wonder.",
    "Nutrition is an important aspect of overall",
    "Nobody is perfect, but we can all strive to be the best version of ourselves.",
    "New experiences can be scary, but they can also be incredibly rewarding.",
    "Online learning has become increasingly popular in recent years.",
    "Opportunities are everywhere if you are willing to look for them.",
    "Positive thinking can help you overcome challenges and achieve your goals.",
    "Quiet moments of reflection can help you gain clarity and perspective.",
    "Reading is a great way to expand your knowledge and imagination.",
    "Self-care is an essential part of maintaining good physical and mental health.",
    "Traveling is a great way to learn about different cultures and traditions.",
    "Understanding different perspectives can help us build empathy and compassion.",
    "Volunteering is a great way to give back to your community and make a difference.",
    "Walking is a simple but effective way to get some exercise and clear your mind.",
    "Xenophobia is the fear or hatred of people from different countries or cultures.",
    "You are capable of achieving great things if you believe in yourself and work hard.",
    "Zoology is the scientific study of animals and their behavior.",
    "Zebras are known for their distinctive black and white stripes.",
]

