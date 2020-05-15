//
//  TestBrain.swift
//  LoveTester
//
//  Created by Magdalena  Pękacka on 11/05/2020.
//  Copyright © 2020 Magdalena  Pękacka. All rights reserved.
//import Foundation

struct TestBrain {
    
    var questionNumber = 0
    
    var test = [Test(q: "From the first meeting, something attracted us to each other.", a: ""),
                Test(q: "I try to keep him a little uncertain about my commitment to our relationship.", a: ""),
                Test(q: "It wasn't until I had loved him for some time that I realized that love.", a: ""),
                Test(q: "Before I get involved with anyone, I try to imagine who he will become in the future.", a: ""),
                Test(q: "When things go wrong between us, I get a stomach upset.", a: ""),
                Test(q: "I try my best to help him when he is in trouble.", a: ""),
                Test(q: "Something like the right chemical reaction occurs between us.", a: ""),
                Test(q: "He'll be fine if he doesn't know certain things about me. ", a: ""),
                Test(q: "I try to plan my life carefully before choosing a partner.", a: ""),
                Test(q: "When I fail in a relationship in which I am deeply involved, I get so depressed that I even think about suicide.", a: ""),
                Test(q: "Rather, I would rather suffer than let him suffer.", a: ""),
                Test(q: "Our physical love is very intense and satisfying.", a: ""),
                Test(q: "Sometimes I am in a situation where I have to be careful that none of my partners find out about the existence of the other", a: ""),
                Test(q: "To this day, he remains in friendly relations with almost everyone I used to love,", a: ""),
                Test(q: "the best is to love someone with similar views and life experiences,", a: ""),
                Test(q: "sometimes the thought of being in love so stimulates me that I can't sleep", a: ""),
                Test(q: "I can't be happy until I put his happiness above my own", a: ""),
                Test(q: "I think we were destined for each other", a: ""),
                Test(q: "Easily and quickly shakes off a failed relationship", a: ""),
                Test(q: "Best love grows out of long-lasting Friendship", a: ""),
                Test(q: "The main criterion in choosing a partner is for me how he views my family when he doesn't pay attention to me my physical well-being deteriorates usually", a: ""),
                Test(q: "I am usually willing to sacrifice my desires if it would allow him to realize his own.", a: ""),
                Test(q: "We both got involved very quickly emotionally in our relationship.", a: ""),
                Test(q: "I think my partner would get upset if he learned about some things they do with other people,", a: ""),
                Test(q: " it is difficult to pinpoint the moment when we fell in love", a: ""),
                Test(q: "an important thing when choosing a partner is whether he turns out to be a good father when I'm in love", a: ""),
                Test(q: " I have trouble concentrating on something else", a: ""),
                Test(q: "My partner can use according to his own will everything that belongs to me,", a: ""),
                Test(q: "we understand each other very well.", a: ""),
                Test(q: " When my partner gets addicted to me too much I feel like withdrawing a little bit", a: ""),
                Test(q: "love is in fact a deep friendship and is not some mystical mysterious feeling ", a: ""),
                Test(q: "one of the criteria for choosing a partner is as he supplies my work", a: ""),
                Test(q: "I can't relax when I suspect he is at the moment with someone else Even when it is played on me I still fully and unconditionally love him", a: ""),
                Test(q: "I think that he perfectly matches my ideal of physical beauty", a: ""),
                Test(q: "I like to play a little in love with several different partners my most successful love relationships grew out of good Friendship", a: ""),
                Test(q: "before I get involved with someone seriously I am trying to figure out What traits are inherited in his family in case we had sometime children", a: ""),
                Test(q:  "when he doesn't pay attention to me even for a moment I happen to do various stupid things to regain his interest", a: ""),
                Test(q: "for him I would withstand everything", a: "")
                    
        
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
