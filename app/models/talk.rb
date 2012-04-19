class Talk < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description

  has_many :votes

  def vote_count
    votes.count
  end

   def cast_vote!
    Vote.create(:talk_id => self.id)
  end
end
