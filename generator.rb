#! /usr/bin/env ruby

require "yaml"
require "erb"
require "ostruct"

phrases = YAML.load(File.read("phrases.yaml"))
template = ERB.new(File.read("template.erb"))

phrases.each do |language, mappings|
  os = OpenStruct.new(mappings)
  def os.get_binding
    binding
  end
  html = template.result(os.get_binding)

  File.open("template-#{language}.html", "w") { |f| f.write(html) }
end
