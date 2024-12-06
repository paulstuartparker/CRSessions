class CreativeSessionCardComponent < ViewComponent::Base
  def initialize(creative_session:)
    @creative_session = creative_session
  end

  private
  attr_reader :creative_session
end
