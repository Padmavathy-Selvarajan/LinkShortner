class Link < ActiveRecord::Base
  validates_presence_of :given_url
    has_many :clicks
    has_many :users, :through => :clicks


  def shorten(url)
	chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map { |range| range.to_a }.flatten
	self.shortened_url = 5.times.map { chars.sample }.join
  end

end
