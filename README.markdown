Introduction
============
Flotr (pron.: like "plotter") is a plot/chart facility to be used within Ruby.

It is intended to be as portable as possible, and is thus aimed to generate HTML plots thanks to the great [flot library](http://ryanfunduk.com/flot).

Installation
============
First, you have to be sure to have the Github repository added to your rubygems configuration. This step only has to be performed the first time you install a gem hosted on Github:

    gem sources -a http://gems.github.com

Next, simply install the gem:

    sudo gem install pbosetti-flotr

Usage
=====
The following code produces the `flotr.html` file located in the current folder:

    require "rubygems"
    require "flotr"
    # Create a new plot
    plot = Flotr::Plot.new("Test plot")

    # Create two empty series
    sin = Flotr::Data.new(:label => "Sin(x)", :color => "red")
    cos = Flotr::Data.new(:label => "Cos(x)", :color => "blue")

    # Push data into the two series
    100.times do |i| 
      sin << [i, Math::sin(Math::PI / 100 * i)]
      cos << [i, Math::cos(Math::PI / 100 * i)]
    end

    plot << sin << cos
    plot.show

At the moment, the `Flotr::Plot.show` method automatically opens the plot within a browser window under OS X and Windows. On other platforms (Linux) you have to open the generated file by hands.

The default template (since v1.3) allows zooming the plot. Reload the page to reset to full view.

Templates
=========
Flotr uses templates for formatting the plots. Currently there are the following templates available:

1. `interacting`: a simple layout that shows point coordinates on mouse hover
2. `zooming`: a smaller overview is added on the right side of the main plot, allowing zooming of different plot areas

The current template can be selected as follows (amongst those installed by default):

    p = Flotr::Plot.new
    p.std_template                  #=> "zooming"
    p.std_templates                 #=> ["interacting" , "zooming"]
    p.std_template = "interacting"
    p.std_template                  #=> "interacting"
    
Custom templates can be selected this way:

    p.template = "full/path/to/template.rhtml"
    
Look within `lib/*.rhtml` for template examples. Templates follow the Erubis syntax.

Example
=======

![Obligatory example](http://cloud.github.com/downloads/pbosetti/flotr/plot.png)

Thanks to
=========
The author of jflot, [Ryan Funduk](http://ryanfunduk.com/flot)