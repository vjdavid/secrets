module ExternalAPIS
  class StarWars
    include HTTParty
    base_uri('http://gateway.marvel.com')

    PRIVATE_KEY = "myprivate_key"
    PUBLIC_KEY = "my_public_key"

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
    end

  end
end
