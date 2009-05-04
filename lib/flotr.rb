#!/usr/bin/env ruby
#
# Created by Paolo Bosetti on 2009-04-27.
# Copyright (c) 2009 University of Trento. All rights 
# reserved.
require "rubygems"
require "erubis"
require "CGI"

class String
  def escapeHTML
    CGI.escapeHTML self
  end
end

module Flotr
  BASENAME = File.dirname(__FILE__)
  OUTPUT_FILE = "flotr.html"
  STD_TEMPLATE = "zooming.rhtml"
  
  class Data
    OPTIONS = [:color, :label, :lines, :bars, :points, :hints, :shadowSize]
    attr_accessor *OPTIONS
    attr_accessor :data
    
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
    attr_accessor :series, :title, :comment, :template, :options
    attr_accessor :width, :height
    attr_accessor :label, :xlim, :ylim
    
    def initialize(title = "Flotr Plot")
      @title = title
      @template = "#{BASENAME}/#{STD_TEMPLATE}"
      @series = []
      @options = {}
      @width, @height = 600, 300
      @label = @xlim = @ylim = {}
    end
    
    def std_templates
      Dir.glob("#{BASENAME}/*.rhtml").map {|f| File.basename(f, ".rhtml")}
    end
    
    def std_template=(template)
      @template = "#{BASENAME}/#{template}.rhtml"
    end
    
    def std_template
      if File.dirname(@template) == BASENAME
        File.basename(@template, ".rhtml")
      else
        nil
      end
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
        exec "start #{OUTPUT_FILE}"
      else
        puts "open #{OUTPUT_FILE} in your preferred brouser"
      end
    end
    
    alias show plot
    
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

