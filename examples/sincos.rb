#!/usr/bin/env ruby
#
# Created by Paolo Bosetti on 2009-04-27.
# Copyright (c) 2009 University of Trento. All rights 
# reserved.

require "../lib/flotr"

sin = Flotr::Data.new(:label => "Sin(x)", :color => "red")
cos = Flotr::Data.new(:label => "Cos(x)", :color => "blue")

100.times do |i| 
  cos << [i, Math::cos(Math::PI / 100 * i)]
  sin << [i, Math::sin(Math::PI / 100 * i)]
end

plot = Flotr::Plot.new("Test plot")
plot.comment = "This is a test plot made with Flotr"
plot.options = {:legend_position => "ne", :points => 'true'}
plot.height = 480
plot.width = 640
plot.label = {:X => "X"}   # :Y label seems not working on Safari
plot.ylim = {:min=> -1.5, :max => 1.5}
plot << sin
plot << cos
plot.show