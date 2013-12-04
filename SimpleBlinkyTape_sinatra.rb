require 'rubygems'
require 'sinatra'
require "sinatra/reloader" # sinatra-contrib
require 'color/css'  # Color::CSS
require './SimpleBlinkyTape.rb'
bt = SimpleBlinkyTape.new

get '/' do
  "Hello. Try:
  <ul><li>/set/FFFF00</li><li>/set/red</li><li>/fade/purple</li><li>fadedown 30</li><li>fadeup 10</li></ul>"
end

get '/fadeup/?:secs?' do
  puts "FADEUP"
  handle_fadeup(params[:secs], bt)
end

get '/fadedown/?:secs?' do
  puts "FADEDOWN"
  handle_fadedown(params[:secs], bt)
end

get '/set/?:colour?' do
  puts "SET"
  handle_set(params[:colour], bt)
end

get '/fade/?:colour?' do
  puts "FADE"
  handle_fade(params[:colour], bt)
end

def get_colour(name)
  colour = (Color::CSS[name])
  if (colour)
    colour = colour.to_rgb
  else
    colour = Color::RGB.from_html(name)
  end
  return colour
end

def show_colour_form(method, colour, name)
  return "<html><body style='background-color:#{"#%02x%02x%02x" % [colour.red, colour.green, colour.blue]}'><form name='input' action='#{method}' method='get'><input type='text' name='colour'></form><p/>#{name} (red: #{colour.red} green: #{colour.green} blue: #{colour.blue})</body></html>"
end

def show_fade_form(method, secs)
  return "<html><body><form name='input' action='#{method}' method='get'><input type='text' name='secs'></form><p/>#{secs}</body></html>"
end

def handle_set(name, bt)
  colour = get_colour(name)
  bt.set(colour.red, colour.green, colour.blue)
  return show_colour_form('/set', colour, name)
end

def handle_fade(name, bt)
  colour = get_colour(name)
  bt.fade(colour.red, colour.green, colour.blue)
  return show_colour_form('/fade', colour, name)
end

def handle_fadeup(secs, bt)
  bt.fadeup(secs)
  return show_fade_form('/fadeup', secs)
end

def handle_fadedown(secs, bt)
  bt.fadedown(secs)
  return show_fade_form('/fadedown', secs)
end

