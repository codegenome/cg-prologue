$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'prologue'
Prologue::GEM_ROOT = File.expand_path( File.dirname( __FILE__ ) + '/../' )
