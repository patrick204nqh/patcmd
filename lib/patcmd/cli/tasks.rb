# frozen_string_literal: true

module Patcmd
  module CLI
    module Tasks
      Dir[File.join(__dir__, "tasks", "*.rb")].each do |file|
        require file
      end
    end
  end
end
