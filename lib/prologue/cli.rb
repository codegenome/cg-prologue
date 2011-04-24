require 'active_support/secure_random'
require 'thor'
require 'thor/actions'

module Prologue

  class CLI < Thor

    # Includes
    include Thor::Actions

    desc "new [app]", "Create a new Rails 3 application"
    long_desc <<-D
      Prologue will ask you a few questions to determine what features you
      would like to generate. Based on your answers it will setup a new Rails 3 application.
    D
    def new( project , template_name = "default" )

      # Require the template runner
      require "#{::PROLOGUE_GEM_ROOT}/templates/#{template_name}/#{template_name}.rb" or raise Prologue::Errors::TemplateRunnerNotImplementedError

      # Invoke the template runner
      invoke "prologue:templates:#{template_name}:on_invocation"

      # Execute the template
      exec(<<-COMMAND)
        rails new #{project} \
          --template=#{::PROLOGUE_GEM_ROOT}/templates/#{template_name}/bootstrap.rb \
          --skip-test-unit \
          --skip-prototype
      COMMAND

    end

    desc "version", "Prints Prologue's version information"
    def version
      say "Prologue version #{Prologue::VERSION}"
    end
    map %w(-v --version) => :version

  end

end

