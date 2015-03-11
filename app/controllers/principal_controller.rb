class PrincipalController < ApplicationController

  def index
  end


  def create
    respond_to { |format| format.js }
  end
end
