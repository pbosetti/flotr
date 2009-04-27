Introduction
============
Flotr (pron.: like "plotter") is a plot/chart facility to be used within Ruby.

It is intended to be as portable as possible, and is thus aimed to generate HTML plots thanks to the great [flot library](http://ryanfunduk.com/flot).

Usage
=====
The following code produces the flotr.html file located in the root project folder:

    require "lib/flotr"

    sin = Flotr::Data.new(:label => "Sin(x)", :color => "red")
    100.times {|i| sin.data << [i, Math::sin(Math::PI / 100 * i)]}
    cos = Flotr::Data.new(:label => "Cos(x)", :color => "blue")
    100.times {|i| cos.data << [i, Math::cos(Math::PI / 100 * i)]}


    plot = Flotr::Plot.new("Test plot")
    plot.comment = "This is a test plot made with Flotr"
    plot.options[:legend_position] = "ne"
    plot.height = 480
    plot.width = 640
    plot << sin
    plot << cos
    plot.plot

At the moment, the Flotr::Plot.plot method automatically opens the plot within a browser window under OS X only. On Windows, you have to open the generated file by hands.

Thanks to
=========
The author of jflot, [Ryan Funduk](http://ryanfunduk.com/flot)