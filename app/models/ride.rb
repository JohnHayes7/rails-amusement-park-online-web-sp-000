class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction

    def take_ride
        if !tall_enough? && !enough_tickets?
            "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
        elsif !tall_enough?
            "Sorry. You are not tall enough to ride the #{self.attraction.name}." 
        elsif !enough_tickets?
            "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
        else
            update_user_values
            "Thanks for riding the #{self.attraction.name}!"
        end
    end


    def enough_tickets?
      self.user.tickets >= self.attraction.tickets
    end

    def tall_enough?
        self.user.height >= self.attraction.min_height
    end

    def update_user_values
        self.user.tickets -=self.attraction.tickets
        self.user.nausea += self.attraction.nausea_rating
        self.user.happiness += self.attraction.happiness_rating
        self.user.save
    end

    
    
   

end
