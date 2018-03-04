require 'twitter'
require 'csv'

num_attempts = 0
MAX_ATTEMPTS = 3 

class TheCollector


Darky = Twitter::REST::Client.new do |config|

	config.consumer_key         = "l1lWzn0eCfw8DB3rRkLaNsemt"
	config.consumer_secret      = "kX8j2uszwRrKOzfTjYzV5doix0SRoZfqK8FFTWIR4Dq7Ek4YoQ"
	config.access_token         =	"894831813289496576-OeawGwr7hqn9HQ4pwXHpkF5OcolwBDB"
	config.access_token_secret  = "O4c8w4ihYwWgmWXKpDNbhUnvkxMrTtyik7rAQoBR0Ipkm"
	end

  SLICE_SIZE = 100

  def fetch_all_following(twitter_username)
    CSV.open("#{twitter_username}_friends_list.txt", 'w') do |csv|
    Darky.following(twitter_username).each_slice(SLICE_SIZE).with_index do |slice, i|
        Darky.users(slice).each_with_index do |f, j|
          csv << [f.id]
        end
      end
    end
  end
end

begin
 Mine = TheCollector.new
 Mine.fetch_all_following('david0_darky')
rescue Twitter::Error::TooManyRequests => error
    puts 'Requested too many times, retrying..'
      if num_attempts <= MAX_ATTEMPTS
      puts error.rate_limit.reset_in
        sleep error.rate_limit.reset_in
        retry
      end
end

	begin
	

	lines = IO.readlines("david0_darky_friends_list.txt").to_a     
	prev_line = nil
		lines.take(5).each do |line|                 
			if prev_line
				Darky.unfollow(prev_line.to_i)
				puts "unfollowed #{prev_line}"
			end
	prev_line = line 
	end
	rescue Twitter::Error::NotFound => e
  puts e.inspect
	puts 'ok'

	rescue Twitter::Error::TooManyRequests => error
    puts 'Requested too many times, retrying..'
      if num_attempts <= MAX_ATTEMPTS
      puts error.rate_limit.reset_in
        sleep error.rate_limit.reset_in
        retry
      end
			sleep 5
  end

	
	

