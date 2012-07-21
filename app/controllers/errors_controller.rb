class ErrorsController < ApplicationController

  def not_found
    render action: 404, layout: "error", status: 404
  end

end
