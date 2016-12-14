class PostsController < ApplicationController
  around_action :wrap_in_transaction, only: [:create, :archive, :vote]

  def show
  end

  def index
  end

  def create
  end

  def archive
  end

  def vote
  end

  def share
  end

  private

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      ensure
        raise ActiveRecord::Rollback
      end
    end
  end
end
