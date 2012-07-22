class ErrorsController < ApplicationController

  def render_error
    render action: "error", layout: "error", locals: { error: code }, status: code
  end

  private

  def code
    request.fullpath.split("/").last.to_i
  end

end
