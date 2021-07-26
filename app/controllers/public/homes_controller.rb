# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def about
  end

  def top
    @items = Item.all
  end

  def question
  end

  def mail
  end

  def company
  end
end
