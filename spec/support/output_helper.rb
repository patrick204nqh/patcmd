# frozen_string_literal: true

module OutputHelper
  # Captures STDOUT output during the execution of the block.
  # Returns the captured output as a string.
  def capture_stdout
    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
end
