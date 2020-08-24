# frozen_string_literal: true

class TodolistsController < ApplicationController
  def show
    @todolist = Todolist.find_by!(slug: params[:id])
  end
end
