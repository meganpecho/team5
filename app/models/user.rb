class User < ApplicationRecord
    #attr_accessible :name, :price, :released_on
    before_save { email.downcase! }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    
    validates :password, presence: true, length: { minimum: 8 }, on: :create
    
    def is_setup?
        return self.setup
    end
    
    def major
       return Major.where(id: self.major_id)[0]
    end
    
    def major_title
        major = Major.where(id: self.major_id)[0]
        if major
            return major.full_title
        end
    end
    
    def courses
        return JSON.parse(self.course_ids).map{ |i| Course.find(i) }
    end
  
    #def self.to_csv
    #  CSV.generate do |csv|
    #    csv << column_names
    #    all.each do |datatable|
    #      csv << datatable.attributes.values_at('Name', 'Major', 'Email', 'Courses Taken')
    #    end
    #  end
    #end
    
    def to_csv
      attributes = %w{id email name course_ids major_title created_at}
      
      CSV.generate(headers: true) do |csv|
        csv << attributes
        csv << attributes.map{ |attr| self.send(attr) }
      end
    end
    
    def self.to_csv
      attributes = %w{id email name course_ids major_title created_at}
      
      CSV.generate(headers: true) do |csv|
        csv << attributes
      
        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end
end

