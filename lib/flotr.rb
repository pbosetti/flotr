#!/usr/bin/env ruby
#
# Created by Paolo Bosetti on 2009-04-27.
# Copyright (c) 2009 University of Trento. All rights 
# reserved.
require "rubygems"
require "erubis"
require "cgi"

class String
  def escapeHTML
    CGI.escapeHTML self
  end
end

=begin rdoc
  Flotr namespace.
=end
module Flotr
  BASENAME = File.dirname(__FILE__)
  OUTPUT_FILE = "flotr.html"
  STD_TEMPLATE = "zooming.rhtml"
  
  
=begin rdoc
  Series to be plotted are instance of the Flotr::Data class. Initialize a new
  Data object with a set of OPTIONS, then add points with the << method.
=end
  class Data
    OPTIONS = [:color, :label, :lines, :bars, :points, :hints, :shadowSize]
    attr_accessor *OPTIONS
    attr_accessor :data
    
=begin rdoc
  Creates a new serie of points. opts is a Hash with a subset of the keys
  given in OPTIONS.
=end
    def initialize(opts={})
      @data = []
      opts.each do |k,v|
        if OPTIONS.include? k
          self.send(k.to_s+'=', v)
        else
          warn "Warning: data option '#{k}' does not exist, ignored"
        end
      end
    end
    
=begin rdoc
  Provides a JavaScript-formatted description of the data array.
=end
    def inspect
      options = ""
      OPTIONS.each do |o|
        if self.send o then
          options += "#{o}: \"#{self.send o}\", "
        end
      end
      "{ #{options}data: #{@data.inspect}}"
    end
    
=begin rdoc
  Adds other to the data array. other must be a two element array like [0,0].
=end
    def <<(other)
      other = other.to_a
      raise ArgumentError unless other[0].kind_of? Numeric
      raise ArgumentError unless other[1].kind_of? Numeric
      @data << other
    end
    
  end
  
=begin rdoc
  The Plot object. Serves as a container for the data series (Data objects)
  and for the plot options. Call the plot/show methods to generate the 
  plot file Flotr::OUTPUT_FILE.
=end  
  class Plot
    attr_accessor :series, :title, :comment, :template, :options
    attr_accessor :width, :height
    attr_accessor :label, :xlim, :ylim
    
=begin rdoc
  Creates a new plot. You only have to provide a title for the plot, that
  will (probably) be used as a page title by the active template.
=end
    def initialize(title = "Flotr Plot")
      @title = title
      @template = "#{BASENAME}/#{STD_TEMPLATE}"
      @series = []
      @options = {}
      @width, @height = 600, 300
      @label = @xlim = @ylim = {}
    end
    
=begin rdoc
  Lists the available standard templates. These are .rhtml files located in
  the lib floder inside the gem. The extension .rhtml is dropped.
=end
    def std_templates
      Dir.glob("#{BASENAME}/*.rhtml").map {|f| File.basename(f, ".rhtml")}
    end
    
=begin rdoc
  Selects the active template. It has to be one of those included in the
  result of the std_templates method.
=end
    def std_template=(template)
      raise "Template #{template} does not exist!" unless self.std_templates.include?(template) 
      @template = "#{BASENAME}/#{template}.rhtml"
    end

=begin rdoc
  Returns the currently selected standard template, or nil if the active
  template is a custom one. Use Plot#template=(full/path/to/template.rhtml)
  to set a custom template.
=end
    def std_template
      if File.dirname(@template) == BASENAME
        File.basename(@template, ".rhtml")
      else
        nil
      end
    end
    
=begin rdoc
  Generates the html file containing the plot and fires up a preferred
  browser window with the plot loaded.
=end
    def plot
      eruby = Erubis::Eruby.new(File.read(@template))
      File.open(OUTPUT_FILE, 'w') do |f|
        f.print eruby.result(binding())
      end
      case RUBY_PLATFORM
      when /darwin/
        exec "open \"#{OUTPUT_FILE}\""
      when /mswin/
        exec "start #{OUTPUT_FILE}"
      else
        puts "open #{OUTPUT_FILE} in your preferred brouser"
      end
    end
    
    alias show plot
    
=begin rdoc
  Adds a Data serie to the Plot. It also returns self, so multiple calls
  can be concatenated as in plot << series1 << series2 << series3.
=end
    def <<(serie)
      if serie.instance_of? Data
        @series << serie
      else
        raise ArgumentError
      end
    end
    
=begin rdoc
  Provides a JavaScript-formatted description of the all the series.
=end
    def inspect
      data = @series.map {|s| s.inspect}
      "[ #{data*', '} ]"
    end
  end
  
end

