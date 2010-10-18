module Prologue
  class Error < StandardError
  end

  # Raised when a task was not found.
  #
  class UndefinedTaskError < Error
  end

  # Raised when a task was found, but not invoked properly.
  #
  class InvocationError < Error
  end

  class UnknownArgumentError < Error
  end

  class RequiredArgumentMissingError < InvocationError
  end

  class MalformattedArgumentError < InvocationError
  end
end