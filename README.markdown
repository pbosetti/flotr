Introduction
============
Flotr (pron.: like "plotter") is a plot/chart facility to be used within Ruby.

It is intended to be as portable as possible, and is thus aimed to generate HTML plots thanks to the great [flot library](http://ryanfunduk.com/flot).

Usage
=====
The following code produces the flotr.html file located in the root project folder:

    require "lib/flotr"
    # Create a new plot
    plot = Flotr::Plot.new("Test plot")

    # Create two empty series
    sin = Flotr::Data.new(:label => "Sin(x)", :color => "red")
    cos = Flotr::Data.new(:label => "Cos(x)", :color => "blue")

    # Push data into the two series
    100.times do |i| 
      sin.data << [i, Math::sin(Math::PI / 100 * i)]
      cos.data << [i, Math::cos(Math::PI / 100 * i)]
    end

    plot << sin
    plot << cos
    plot.show

At the moment, the Flotr::Plot.plot method automatically opens the plot within a browser window under OS X and Windows. On other platforms (Linux) you have to open the generated file by hands.

The default template (since v1.3) allows zooming the plot. Reload the page to reset to full view.

Example
=======

![Obligatory example](http://cloud.github.com/downloads/pbosetti/flotr/plot.png)

Thanks to
=========
The author of jflot, [Ryan Funduk](http://ryanfunduk.com/flot)