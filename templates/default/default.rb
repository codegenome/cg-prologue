require 'securerandom'

module Prologue

  module Templates

    class Default < Prologue::TemplateRunner

      # Class Options
      # @see https://github.com/wycats/thor/wiki/Groups
      class_option :auth  , :type => :boolean , :default => true , :banner => "Sets up devise for authentication."
      class_option :roles , :type => :boolean , :default => true , :banner => "Sets up cancan for authorization with roles."
      class_option :admin , :type => :boolean , :default => true , :banner => "Sets up very basic admin"

      # Descriptions
      desc "Runs the default prologue Rails 3 stack task"

      # The method to run when the template is invoked
      def on_invocation

        # Dup our options so we can modify them
        opts = options.dup

        # Can't build an admin or roles without devise
        if !opts[:auth]
          opts[:admin] = false;
          opts[:roles] = false;
        end

        # Env vars used in our template
        ENV['PROLOGUE_AUTH']  = "true" if opts[:auth]
        ENV['PROLOGUE_ADMIN'] = "true" if opts[:admin]
        ENV['PROLOGUE_ROLES'] = "true" if opts[:roles]
        ENV['PROLOGUE_USER_NAME'] = git_user_name if opts[:admin]
        ENV['PROLOGUE_USER_EMAIL'] = git_user_email if opts[:admin]
        ENV['PROLOGUE_USER_PASSWORD'] = user_password if opts[:admin]

      end

      private

      def git_user_name
        `git config --global user.name`.chomp.gsub('"', '\"') || "Quick Left"
      end

      def git_user_email
        `git config --global user.email`.chomp || "me@me.com"
      end

      def user_password
        SecureRandom.base64(8)
      end

    end

  end

end

