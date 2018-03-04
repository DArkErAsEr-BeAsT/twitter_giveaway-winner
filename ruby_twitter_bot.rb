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

class GiveawayBot


  n = 0
  MAX_ATTEMPTS = 3
  num_attempts = 0
  i = rand(60..90)
  PUSHBULLET_ACCESS_TOKEN = 'o.FDS7OzY0rhUBVU6HBbj2EEo86hoMpq3Z'
  if __FILE__ == $0
	Pushbullet.set_access_token(PUSHBULLET_ACCESS_TOKEN)
	
  Darky = Twitter::REST::Client.new do |config|

	config.consumer_key         = "l1lWzn0eCfw8DB3rRkLaNsemt"
	config.consumer_secret      = "kX8j2uszwRrKOzfTjYzV5doix0SRoZfqK8FFTWIR4Dq7Ek4YoQ"
	config.access_token         =	"894831813289496576-OeawGwr7hqn9HQ4pwXHpkF5OcolwBDB"
	config.access_token_secret  = "O4c8w4ihYwWgmWXKpDNbhUnvkxMrTtyik7rAQoBR0Ipkm"
	end  

  

  

loop do 
	Darky.search('giveaway -rt' , lang:"en           ", result_type:"recent", max_id:"").each do |tweet|
	
	  begin
	    puts "#{tweet.full_text} : #{tweet.user.screen_name} ; #{tweet.id}"
	    
	    Darky.class
	    Darky.follow("#{tweet.user.screen_name}")
	    puts "followed #{tweet.user.screen_name}"
	    tweet.attrs[:full_text]
	    Darky.favorite("#{tweet.id}")
		  
		  
		  Darky.retweet("#{tweet.id}")
		  num_attempts += 1  
		  n += 1
      puts n
      puts "---------------------------------------------------------------" 
      sleep(i)    
   
   rescue Twitter::Error::TooManyRequests => error
     puts 'Requested too many times, retrying..'
       if num_attempts <= MAX_ATTEMPTS
       puts error.rate_limit.reset_in
		     sleep error.rate_limit.reset_in
		     next 
	     end
	     
	     
	 rescue HTTP::ConnectionError 
	   puts 'Encountered a Connection Issue, retrying..'
	   sleep(i)
	   error_text = "HTTP::ConnectionError => NEtwork is probably down ! => Restarting in 15 !"
	   Pushbullet::V2::Push.note("ERROR Report ", error_text.gsub(' ', "\u00a0"))
	   
	   retry
	 
	 rescue SocketError
	 puts ' Pushbullet not responding, trying again in a few seconds..'
	 sleep(i)
   puts (SocketError.class.inspect)
   
   rescue Twitter::Error::Forbidden 
	   puts 'Encountered a Duplicate, retrying..'
	   sleep(i)
	   next
	   
	 rescue Twitter::Error::NotFound
	   puts 'No User is registered under that name, proceeding to the next one !'
	   sleep(i)
	   next
	   
   rescue Errno::ENETUNREACH
		puts "Probably a Network glitch.. Retrying in a few seconds !!"
		sleep(i)
		retry 
	 
	 rescue Twitter::Error::Unauthorized
	 puts " User has blocked you !"
	 sleep(i)
	 next
	 
	 rescue HTTP::ConnectionError
	 	 sleep(i)
	 	 retry

		
   raise StandardError
		 error_text = "Some Error occured ! PLease check your log file ! "
	   Pushbullet::V2::Push.note("ERROR Report ", error_text.gsub(' ', "\u00a0"))

   
	   end    
   end
 end
end
end
 
  
   
  
  	
    
  
 	
  






