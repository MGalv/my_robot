$:.unshift(File.expand_path('../../lib', __FILE__))
require 'robot'

prompt = '> '
help = %Q{
## Thanks for using my robot'

This application is a simulation of a toy robot moving on a square
tabletop, of dimensions 5 units x 5 units.

# Commands:
PLACE X,Y,F - will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
MOVE        - will move the toy robot one unit forward in the direction it is currently facing.
LEFT        - will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
RIGHT       - will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
REPORT      - will announce the X,Y and F of the robot.
EXIT        - will stop the application execution.
?           - Will show the commands list.
}
puts help
print prompt

@robot = Robot.new

def place(input)
  x, y, facing= input.split(' ')[1].split(',')
  @robot.place(x.to_i, y.to_i, facing)
  @robot = @robot unless @robot.placed
end

while command = gets.chomp
  case command.upcase
    when /PLACE\s\d\,\d\,\w+/
      place(command)
      print prompt
    when 'MOVE'
      @robot.move
      print prompt
    when 'LEFT'
      @robot.left
      print prompt
    when 'RIGHT'
      @robot.right
      print prompt
    when 'REPORT'
      puts @robot.report
      print prompt
    when 'EXIT'
      puts 'Ciao!'
      break
    when '?'
      puts help
      print prompt
    else
      puts 'Command not found: for help, type "?".'
      p command
      print prompt
  end
end
