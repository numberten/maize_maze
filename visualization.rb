require 'rubygems'
require 'gosu'


#a = gets


input = gets
s = input.split(/\:/)
puts s
$grid_width = Integer(s[0])
$grid_height = Integer(s[1])
visualization = Integer(s[2])
puts visualization

ARGF.each_line do |e|
   input = input + e
end
$cells = input.scan(/\[\d+\]\[\d+\]\[\d, \d, \d, \d\]/)
#puts $cells
#puts $grid_width
#puts $grid_height
if (visualization == 1)
$dir = "./art/"
$grid_width = $grid_width*20
$grid_height = $grid_height*20
$scale = 0.1
$mult = 20
else
$grid_width = ($grid_width*28.8).ceil#20
$grid_height = ($grid_height*28.8).ceil#20
$dir = "./art2/"
$scale = 0.2
$mult = 28.8
end

class GameWindow < Gosu::Window
         def initialize
	    super $grid_width, $grid_height, false
	    self.caption = "Maize Maze Maize"
            @p0000 = Gosu::Image.new(self, $dir+"0000.png", false)
            @p0001 = Gosu::Image.new(self, $dir+"0001.png", false)
            @p0010 = Gosu::Image.new(self, $dir+"0010.png", false)
            @p0011 = Gosu::Image.new(self, $dir+"0011.png", false)
            @p0100 = Gosu::Image.new(self, $dir+"0100.png", false)
            @p0101 = Gosu::Image.new(self, $dir+"0101.png", false)
            @p0110 = Gosu::Image.new(self, $dir+"0110.png", false)
            @p0111 = Gosu::Image.new(self, $dir+"0111.png", false)
            @p1000 = Gosu::Image.new(self, $dir+"1000.png", false)
            @p1001 = Gosu::Image.new(self, $dir+"1001.png", false)
            @p1010 = Gosu::Image.new(self, $dir+"1010.png", false)
            @p1011 = Gosu::Image.new(self, $dir+"1011.png", false)
            @p1100 = Gosu::Image.new(self, $dir+"1100.png", false)
            @p1101 = Gosu::Image.new(self, $dir+"1101.png", false)
            @p1110 = Gosu::Image.new(self, $dir+"1110.png", false)
            @p1111 = Gosu::Image.new(self, $dir+"1111.png", false)
            @test = Gosu::Image.new(self, "../../ruby_scripts/gosu/cell_growth/cell.png", true)
         end

         def needs_cursor?
	    false
         end

         def button_down(id)
	    case id
	    when Gosu::KbEscape
	       close
            end
         end

         def update

         end

         def draw_tile(tile_string)
            tile = get_tile(tile_string)
            #tile.draw((Integer(get_x(tile_string))*28.8).ceil,(Integer(get_y(tile_string))*28.8).ceil,0,$scale, $scale)
            tile.draw((Integer(get_x(tile_string))*$mult).ceil,(Integer(get_y(tile_string))*$mult).ceil,0,$scale, $scale)
         end

         def get_tile(tile_string)
            tile_exits = get_walls(tile_string)
            case tile_exits
               when "0000"
                  return @p0000
               when "0001"
                  return @p0001
               when "0010"
                  return @p0010
               when "0011"
                  return @p0011
               when "0100"
                  return @p0100
               when "0101"
                  return @p0101
               when "0110"
                  return @p0110
               when "0111"
                  return @p0111
               when "1000"
                  return @p1000
               when "1001"
                  return @p1001
               when "1010"
                  return @p1010
               when "1011"
                  return @p1011
               when "1100"
                  return @p1100
               when "1101"
                  return @p1101
               when "1110"
                  return @p1110
               when "1111"
                  return @p1111
            end
         end

         def loot_input(x)
            return x.scan(/\d+/)
         end

         def get_x(x)
            return loot_input(x)[0]
         end

         def get_y(x)
            return loot_input(x)[1]
         end

         def get_walls(x)
            i = loot_input(x)
            return i[2] + i[3] + i[4] + i[5]
         end

         def draw
            for i in $cells
               draw_tile(i)
            end
            #@p1001.draw(50,50,0,0.1,0.1)
            #@p1001.draw(250, 250,0,0.1,0.1)
            #@test.draw(200,0,0)
         end
end

window = GameWindow.new
window.show


