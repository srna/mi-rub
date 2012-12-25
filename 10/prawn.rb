require 'prawn'
require "open-uri"  
  
Prawn::Document.generate("remote_images.pdf") do  
  image open("http://prawn.majesticseacreature.com/images/prawn.png")  
end