railties_path = "#{`echo $rvm_path`.strip}/gems/#{ENV['RUBY_VERSION']}@#{app_name}/gems/railties-3.1.0.rc4/lib/rails"
if File.exists? railties_path
  gsub_file "#{railties_path}/commands/plugin.rb", /Commands/, 'RailsCommands'
end
