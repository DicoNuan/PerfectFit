

import Foundation


class UIRatingModel {
    
    var trainer: UIUserModel
    var punctionalityAndTiming: Int
    var couertosnessAndManners: Int
    var performanceAndKnowledge: Int
    var overallSatisfaction: Int
    
    var publicReview: String
    var trainerFeedback: String
    var privateFeedback: String
    
    init(trainer: UIUserModel, punctionalityAndTiming: Int, couertosnessAndManners: Int, performanceAndKnowledge: Int, overallSatisfaction: Int, publicReview: String, trainerFeedback: String, privateFeedback: String) {
        self.trainer = trainer
        self.publicReview = publicReview
        self.trainerFeedback = trainerFeedback
        self.privateFeedback = privateFeedback
        
        
        self.punctionalityAndTiming = punctionalityAndTiming
        self.couertosnessAndManners = couertosnessAndManners
        self.performanceAndKnowledge = performanceAndKnowledge
        self.overallSatisfaction = overallSatisfaction
    }
    
    func average() -> Int {
        return (punctionalityAndTiming + couertosnessAndManners + performanceAndKnowledge + overallSatisfaction) / 4
    }
}
