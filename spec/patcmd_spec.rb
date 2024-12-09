# frozen_string_literal: true

RSpec.describe(Patcmd) do
  it "has a version number" do
    expect(Patcmd::VERSION).not_to(be(nil))
  end
end
