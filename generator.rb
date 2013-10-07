#! /usr/bin/env ruby

require "yaml"

phrases = YAML.load(File.read("phrases.yaml"))
languages = phrases.keys.map { |key| "#${#{key}}" }
template = File.read("template.html")

phrases.each do |language, mappings|
  t = template.dup

  mappings.each do |key, value|
    t.gsub!("${#{key}}", value)
  end

  File.open("template-#{language}.html", "w") { |f| f.write(t) }
end
