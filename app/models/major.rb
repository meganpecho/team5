class Major < ApplicationRecord
    
    def full_title
        return self.concentration.nil? ? self.title : "#{self.title} / Concentration in #{self.concentration}"
    end
    
end
