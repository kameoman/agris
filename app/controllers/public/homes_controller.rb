# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def about; end

  def top
    @items = Item.all
  end
end
