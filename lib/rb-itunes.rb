require 'rubygems'
require 'rbosa'

module ITunes
	class Search
		itunes = OSA.app('iTunes')
		itunes.run
		@music = itunes.sources.first.library_playlists.first
		
		def self.get_specific_song(options = {})
			raise "Needs database_id" unless options.key?(:database_id)
			name = options[:name] || nil
			artist = options[:artist] || nil
			album = options[:album] || nil
			database_id = options[:database_id]
			
			search_query = "#{name} #{artist} #{album}"
			results = @music.search(search_query)
			results.select {|result| result.database_id == database_id}.first
		end
		
		def self.search_for_songs(search_query)
			results = @music.search(search_query)
		end
	end
end