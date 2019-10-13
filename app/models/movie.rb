class Movie < ActiveRecord::Base
    def self.all_ratings
        return ['G', 'PG', 'PG-13', 'R']
    end

    def self.filter(ratings)
        return Movie.where(rating: [ratings])
    end
end
