class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy how_to_use]

  def top
  end

  def terms
  end

  def privacy
  end

  def how_to_use
  end
end
