require 'json'
require 'ruby2d'
require 'httparty'

def draw_triangle(window)
  input = HTTParty.get('https://api.noopschallenge.com/hexbot?count=3&width=500&height=500')

  color1, color2, color3 = input.parsed_response['colors']

  t = Triangle.new(
    x1: color1['coordinates']['x'], y1: color1['coordinates']['y'],
    x2: color2['coordinates']['x'], y2: color2['coordinates']['y'],
    x3: color3['coordinates']['x'], y3: color3['coordinates']['y'],
    color: [color1['value'], color2['value'], color3['value']]
  )
  window.add(t)
end

set title: 'Hexbot drawing'

draw_triangle(get(:window))

tick = 0
update do
  if (tick % 60).zero?
    draw_triangle(get(:window))
    tick = 0
  end
  tick += 1
end

show
