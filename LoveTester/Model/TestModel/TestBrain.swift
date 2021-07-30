//
//  TestBrain.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 11/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//import Foundation

struct TestBrain {
    
    var questionNumber = 0
    var test = [Test(question: "From the first meeting, something attracted us to each other."),
                Test(question: "I try to keep him a little uncertain about my commitment to our relationship."),
                Test(question: "It wasn't until I had loved him for some time that I realized that love."),
                Test(question: "Before I get involved with anyone, I try to imagine who he will become in the future."),
                Test(question: "When things go wrong between us, I get a stomach upset."),
                Test(question: "I try my best to help him when he is in trouble."),
                Test(question: "Something like the right chemical reaction occurs between us."),
                Test(question: "He'll be fine if he doesn't know certain things about me. "),
                Test(question: "I try to plan my life carefully before choosing a partner."),
                Test(question: "When I fail in a relationship in which I am deeply involved, I get so depressed that I even think about suicide."),
                Test(question: "Rather, I would rather suffer than let him suffer."),
                Test(question: "Our physical love is very intense and satisfying."),
                Test(question: "Sometimes I am in a situation where I have to be careful that none of my partners find out about the existence of the other"),
                Test(question: "To this day, he remains in friendly relations with almost everyone I used to love,"),
                Test(question: "The best is to love someone with similar views and life experiences."),
                Test(question: "Sometimes the thought of being in love so stimulates me that I can't sleep."),
                Test(question: "I can't be happy until I put his happiness above my own"),
                Test(question: "I think we were destined for each other"),
                Test(question: "Easily and quickly shakes off a failed relationship"),
                Test(question: "Best love grows out of long-lasting Friendship"),
                Test(question: "The main criterion in choosing a partner is for me how he views my family when he doesn't pay attention to me my physical well-being deteriorates usually"),
                Test(question: "I am usually willing to sacrifice my desires if it would allow him to realize his own."),
                Test(question: "We both got involved very quickly emotionally in our relationship."),
                Test(question: "I think my partner would get upset if he learned about some things they do with other people,"),
                Test(question: " it is difficult to pinpoint the moment when we fell in love"),
                Test(question: "An important thing when choosing a partner is whether he turns out to be a good father when I'm in love"),
                Test(question: " I have trouble concentrating on something else"),
                Test(question: "My partner can use according to his own will everything that belongs to me,"),
                Test(question: "We understand each other very well."),
                Test(question: " When my partner gets addicted to me too much I feel like withdrawing a little bit"),
                Test(question: "Love is in fact a deep friendship and is not some mystical mysterious feeling "),
                Test(question: "One of the criteria for choosing a partner is as he supplies my work"),
                Test(question: "I can't relax when I suspect he is at the moment with someone else Even when it is played on me I still fully and unconditionally love him"),
                Test(question: "I think that he perfectly matches my ideal of physical beauty"),
                Test(question: "I like to play a little in love with several different partners my most successful love relationships grew out of good Friendship"),
                Test(question: "Before I get involved with someone seriously I am trying to figure out What traits are inherited in his family in case we had sometime children"),
                Test(question:  "When he doesn't pay attention to me even for a moment I happen to do various stupid things to regain his interest"),
                Test(question: "For him I would withstand everything")
        
        
    ]
    
    func getQuestionText() -> String {
        return test[questionNumber].question
    }
    
    mutating func previousQuestion(){
        if questionNumber > 0 {
            questionNumber -= 1
        }
    }
    
    mutating func nextQuestion (){
        
        if questionNumber + 1 < test.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    mutating func updateAnswer (userAnswer: String) {
        test[questionNumber].answer = userAnswer
    }
}
