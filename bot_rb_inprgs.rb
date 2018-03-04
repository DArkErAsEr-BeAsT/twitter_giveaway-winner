#  ruby_twitter_bot.rb
#  Copyright 2018 davd <davd@cherishedhipster>
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#!/usr/bin/env ruby

require 'twitter'
require 'yaml'
require 'pushbullet'
class ConnectionError < StandardError
end

class Tagger 
      def initialize (followers, tweetid, tweetuserscreen_name)
        @followers = followers
        @tweet.id = tweet.id
        @tweet.user.screen_name = username
        Darky.followers.collect.take(10) do |followers|
          Darky.update("@#{tweet.user.screen_name} : Look at this : @#{followers}", :in_reply_to_status_id => "#{tweet.id}")
		end 
  end
      
end
 
class GiveawayBot 
	
  MAX_ATTEMPTS = 3
  num_attempts = 0
  i = rand(60..90)
  PUSHBULLET_ACCESS_TOKEN = 'o.FDS7OzY0rhUBVU6HBbj2EEo86hoMpq3Z'
  if __FILE__ == $0
	Pushbullet.set_access_token(PUSHBULLET_ACCESS_TOKEN)
	
  Darky = Twitter::REST::Client.new do |config|

	config.consumer_key         = "l1lWzn0eCfw8DB3rRkLaNsemt"
	config.consumer_secret      = "kX8j2uszwRrKOzfTjYzV5doix0SRoZfqK8FFTWIR4Dq7Ek4YoQ"
	config.access_token         =	"894831813289496576-xszOdl3u5vHljf94GUexRNOaMwuUY3y"
	config.access_token_secret  = "QhLLk6fWy3qteMHJBam9iAZIKE5uFUHflbkydICCD3lvK"
	end  


	Darky.search('concours' , result_type:"recent", max_id:"").each do |tweet|
	  begin
			tweet.attrs[:full_text]
	    puts "#{tweet.text} : #{tweet.user.screen_name} ; #{tweet.id}"
	    Darky.class
	    Darky.favorite("#{tweet.id}")
      Darky.follow("#{tweet.user.screen_name}")
      Darky.retweet("#{tweet.id}")
      num_attempts += 1
      m = "#{tweet.text}"
	      
	      File.open('yaml.dump', 'w') do |f|
	        f.write(YAML.dump(m))
	        File.read('yaml.dump')
	          
	          if (m.include? 'Tag 2 friends' or m.include? 'Tag 2 Friends' or m.include? 'TAG 2 FRIENDS' or m.include? 'tag 2 friends')
	          Tag2 = Tagger.new("#{followers}", "#{tweet.id}", "#{tweet.user.screen_name}") 
	          puts "Friends Tag Found!"
	          else
	            next
	          end
	  
	          if (m.include? 'Tag a friend' or m.include? 'Tag 1 Friend' or m.include? 'TAG A FRIEND' or m.include? 'tag a friend' or m.include? 'Tag a Friend')
	            puts "Friend Tag Found!"
	          else
	            next
	          end
	        end   
          

   rescue Twitter::Error::TooManyRequests  
     puts 'Requested too many times, retrying..'
     error_text = "Twitter::Error::TooManyRequests => API Requests are limited ! => Retrying as soon as possible !"
	   Pushbullet::V2::Push.note("ERROR Report ", error_text.gsub(' ', "\u00a0"))
       if num_attempts <= MAX_ATTEMPTS
		     sleep(error.rate_limit.reset_in)
	     end
	     
	 rescue HTTP::ConnectionError 
	   puts 'Encountered a Connection Issue, retrying..'
	   error_text = "HTTP::ConnectionError => NEtwork is probably down ! => Restarting in 15 !"
	   Pushbullet::V2::Push.note("ERROR Report ", error_text.gsub(' ', "\u00a0"))
	   sleep(30)
	   retry
	 
	 rescue SocketError
	   puts ' Pushbullet not responding, trying again in a few seconds..'
	   sleep(15)
     
   rescue Twitter::Error::Forbidden 
	   puts 'Encountered a Duplicate, retrying..'
	   sleep(i)
	   next
   
  
      
	 end
   
     
   sleep(i)
  end
 end
end
 
 
 
