class TodosController < ApplicationController
  before_filter :find_todo, :only => [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.all

    respond_to do |wants|
      wants.html # index.html.erb
      wants.json  { render :json => @todos }
    end
  end


  def show
    respond_to do |wants|
      wants.html # show.html.erb
      wants.json  { render :json => @todo }
    end
  end


  def new
    @todo = Todo.new

    respond_to do |wants|
      wants.html # new.html.erb
      wants.json  { render :json => @todo }
    end
  end

  def edit
  end

  def create
    @todo = Todo.new(params[:todo])
    respond_to do |wants|
      if @todo.save
        flash[:notice] = 'Todo was successfully created.'
        wants.html { redirect_to(@todo) }
        wants.json  { render :json => @todo, :status => :created, :location => @todo }
      else
        wants.html { render :action => "new" }
        wants.json  { render :json => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |wants|
      if @todo.update_attributes(params[:todo])
        flash[:notice] = 'Todo was successfully updated.'
        wants.html { redirect_to(@todo) }
        wants.json  { head :ok }
      else
        wants.html { render :action => "edit" }
        wants.json  { render :json => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |wants|
      wants.html { redirect_to(todos_url) }
      wants.json  { head :ok }
    end
  end

  private
    def find_todo
      @todo = Todo.find(params[:id])
    end

end
