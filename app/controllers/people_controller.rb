class PeopleController < ApplicationController

  layout "application"

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      render :action => 'show'
    else
      render :action => 'new'
    end
  end

  def show
    p params
    @person = Person.find_by_name(params[:name])
  end

end
