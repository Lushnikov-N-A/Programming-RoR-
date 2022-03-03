require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'
require_relative 'train'
require_relative 'station'
Train.attr_accessor_with_history('y')

Train.strong_attr_accessor('z',Fixnum)

t = Train.new('qqqqqq','qqq-qq')

t.z='100'

t.z=100

t.y=100

t.y=200

t.y=300

t.y=400

t.y=500

t.y_history

Station.validate('name', 'presence')
Station.validate('name', 'format', /[a-z]{3,}/i.freeze)

s = Station.new('')

s = Station.new('123')

s = Station.new('Qq')

s = Station.new('QqQ')
