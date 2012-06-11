require 'stringio'


# Extending to be able to redirect Yard's #puts output to a variable.
module Kernel

  # @return [String]
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
  end
end
