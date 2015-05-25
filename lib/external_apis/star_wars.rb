class ExternalApis::StarWars
  include HTTParty

  base_uri 'swapi.co/api'

  def show_starships
    self.class.get("/starships/")
  end

  def show_planets
    self.class.get("/planets/")
  end

end
