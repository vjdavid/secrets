class ExternalApis::StarWars
  include HTTParty

  base_uri 'gateway.marvel.com'

  def authentication
    Digest::MD5.hexadigest("#{st}#{private_key}#{public_key}")
  end

  def st
    begin
      Time.now.to_i
    end
  end

  def show_characters
    self.class.get('/v1/public/characters/' authentication)
  end

end
