# frozen_string_literal: true

class ListsController < ApplicationController
  def show
    @list = List.find_by!(slug: params[:id])
  end
end
