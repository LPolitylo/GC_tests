require './versions/ruby_2_4'
class GetStat
	def initialize(*args)
		@strings_count = args[0]
		@forced_full_colection = args[1]
		@forced_minor_colection = args[2]
	end

	def test
		count = ObjectSpace.each_object{ }

		@strings_count.times do |i|
			forced_gc(i, @forced_full_colection, @forced_minor_colection)

			String.new
			c = ObjectSpace.each_object{ }
			if c < count
				puts "GC - Iteration #{i} - Was #{count} now #{c}"
				gc_stat
			end
			count = c
		end
	end

	def gc_stat
		puts "Define this method in this module"
	end

	def forced_gc(i=0, forced_full_colection=nil, forced_minor_colection=nil)
		if [forced_full_colection, forced_minor_colection].include?(i)
			GC.start
		end
	end	
end


# https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html
objects_amount = (ARGV[0] || 30000).to_i

d = case RUBY_VERSION
	when /2\.[1-4]\.\d/ #ruby 2.4
		GetStat.new(objects_amount,100, 0).extend(Ruby_2_4)
	when /2\.[0]\.\d/ #ruby 2.1
		GetStat.new(objects_amount).extend(Ruby_2_1)
	when /1\.9\.\d/ #ruby 1.9
		GetStat.new(objects_amount).extend(Ruby_1_9)
	else
		GetStat.new(objects_amount).extend(Ruby_1_8)
	end

d.test

# https://thorstenball.com/blog/2014/03/12/watching-understanding-ruby-2.1-garbage-collector/
# https://www.speedshop.co/2017/03/09/a-guide-to-gc-stat.html
# https://helabs.com/artigos/2014/12/19/ruby-gc-tuning-parameters/

# https://ruby-doc.org/core-2.2.3/GC.html#method-c-start

# http://patshaughnessy.net/2013/10/30/generational-gc-in-python-and-ruby
# http://patshaughnessy.net/2013/10/24/visualizing-garbage-collection-in-ruby-and-python
# http://patshaughnessy.net/2013/10/30/generational-gc-in-python-and-ruby
# http://patshaughnessy.net/2012/3/23/why-you-should-be-excited-about-garbage-collection-in-ruby-2-0
# https://blog.heroku.com/incremental-gc
# https://en.wikibooks.org/wiki/Ruby_Hacking_Guide/Garbage_Collection#Introducing_GC
# https://stackoverflow.com/questions/5115401/objectspace-what-is-it-and-how-do-people-use-it?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
# https://ruby-doc.org/core-1.9.3/GC.html#method-i-garbage_collect
# https://helabs.com/artigos/2014/12/19/ruby-gc-tuning-parameters/
# https://stackoverflow.com/questions/6067139/ruby-garbage-collect