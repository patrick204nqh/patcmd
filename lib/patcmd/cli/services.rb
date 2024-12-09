# frozen_string_literal: true

module Patcmd
  module CLI
    module Services
      Dir[File.join(__dir__, "services", "*.rb")].each do |file|
        require file
      end
    end
  end
end
