# frozen_string_literal: true

module Patcmd
  module CLI
    module Presenters
      Dir[File.join(__dir__, "presenters", "*.rb")].each do |file|
        require file
      end
    end
  end
end
