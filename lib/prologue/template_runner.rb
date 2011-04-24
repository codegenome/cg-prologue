require 'thor'
require 'thor/actions'
require 'thor/group'

module Prologue

  class TemplateRunner < Thor::Group

    # Standard Arguments
    argument :project , :type => :string

    # Includes
    include Thor::Actions

    # The method to run when the template is invoked. This is used to
    # parse custom options from the command line or complete any other
    # setup prior to invoking the system command that will construct
    # the project.
    def on_invocation
      raise Prologue::Errors::TemplateRunnerInvocationNotImplementedError.new("Template did not define an on_invocation method!")
    end

  end

end

