class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy guide]

  def top
  end

  def terms
  end

  def privacy
  end

  def guide
  end
end
