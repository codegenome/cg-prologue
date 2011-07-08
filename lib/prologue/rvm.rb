module Prologue

  class Rvm

    def self.setup(project, ruby_version)

      # Require local rvm
      rvm_lib_path = "#{`echo $rvm_path`.strip}/lib"
      $LOAD_PATH.unshift(rvm_lib_path) unless $LOAD_PATH.include?(rvm_lib_path)
      require 'rvm'

      env = RVM::Environment.new(ruby_version)

      puts "Creating gemset #{project} in #{ruby_version}"
      env.gemset_create(project)

      puts "Now using gemset #{project}"
      env.use!("#{ruby_version}@#{project}")

      puts "Installing rails gem."
      env.system("gem", "install", "rails", "--version", Prologue::DEFAULT_RAILS_VERSION)

      puts "Installing bundler gem."
      env.system("gem", "install", "bundler")

    end

  end

end
