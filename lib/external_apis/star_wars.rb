module ExternalAPIS
  class StarWars
    include HTTParty
    base_uri('http://gateway.marvel.com')

    PRIVATE_KEY = "835a15c3927ff30091dd8a95fd909e34cfc839f4"
    PUBLIC_KEY = "e9f82a020df98a2bb5ecb2cedff31fd7"

    def show_characters(offset)
      time = Time.now.to_i
      md5_digest = Digest::MD5.hexdigest("#{time}#{PRIVATE_KEY}#{PUBLIC_KEY}")

      self.class.get("/v1/public/characters?offset=#{offset}&ts=#{time}&apikey=#{PUBLIC_KEY}&hash=#{md5_digest}")
    end

    def show_character(id)
      time = Time.now.to_i
      md5_digest = Digest::MD5.hexdigest("#{time}#{PRIVATE_KEY}#{PUBLIC_KEY}")

      self.class.get("/v1/public/characters/#{id}?ts=#{time}&apikey=#{PUBLIC_KEY}&hash=#{md5_digest}")
    end

    def show_all_characters
      time = Time.now.to_i
      md5_digest = Digest::MD5.hexdigest("#{time}#{PRIVATE_KEY}#{PUBLIC_KEY}")

      i = 0
      count = 1
      characters = []

    until i > count do
      request = self.class.get("/v1/public/characters?limit=5&offset=#{i}&ts=#{time}&apikey=#{PUBLIC_KEY}&hash=#{md5_digest}")
      characters << request
      i +=1;
    end

    characters

    binding.pry
    characters[0..1]['data']['results'].map { |name| name['name'] }

    end

  end
end
