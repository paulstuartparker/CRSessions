class SessionCardComponent < ViewComponent::Base
  def initialize(session:)
    @session = session
  end

  private
  attr_reader :session
end 