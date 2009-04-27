#!/usr/bin/env ruby
#
# Created by Paolo Bosetti on 2009-04-27.
# Copyright (c) 2009 University of Trento. All rights 
# reserved.
require "rubygems"
require "erubis"

module Flotr
  
  class Data
    OPTIONS = [:color, :label, :lines, :bars, :points, :hints, :shadowSize]
    attr_accessor *OPTIONS
    attr_accessor :data
    
    def initialize(opts={})
      @data = []
      opts.each do |k,v|
        begin
          self.send(k.to_s+'=', v)
        rescue
          warn "Warning: data option '#{k}' does not exist, ignored"
        end
      end
    end
    
    def inspect
      options = ""
      OPTIONS.each do |o|
        if self.send o then
          options += "#{o}: \"#{self.send o}\", "
        end
      end
      "{ #{options}data: #{@data.inspect}}"
    end
    
    def <<(other)
      @data << other
    end
    
  end
  
  class Plot
    OUTPUT_FILE = "flotr.html"
    attr_accessor :series, :title, :comment, :template, :options
    attr_accessor :width, :height
    
    def initialize(title = "Flotr Plot")
      @title = title
      @template = "lib/interacting.rhtml"
      @series = []
      @options = {}
      @width, @height = 600, 300
    end
    
    def plot
      eruby = Erubis::Eruby.new(File.read(@template))
      File.open(OUTPUT_FILE, 'w') do |f|
        f.print eruby.result(binding())
      end
      case RUBY_PLATFORM
      when /darwin/
        exec "open \"#{OUTPUT_FILE}\""
      when /mswin/
        puts "open #{OUTPUT_FILE} in your preferred brouser"
      end
    end
    
    def <<(serie)
      if serie.instance_of? Data
        @series << serie
      else
        raise ArgumentError
      end
    end
    
    def inspect
      data = @series.map {|s| s.inspect}
      "[ #{data*', '} ]"
    end
  end
  
end

