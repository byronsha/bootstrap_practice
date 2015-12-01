class HeroesController < ApplicationController
  def index
    @heroes = {}
    @hero_images = Dir.glob("app/assets/images/heroes/*.png")

    @hero_images.each do |hero_image|
      @heroes[hero_image[25..-10].split("_").map(&:capitalize).join("_")] = hero_image
    end
  end
end
