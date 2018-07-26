class SearchesController < ApplicationController

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new(job_params)
  end

  private

  def job_params
    params.require(:job).permit(:job_title, :description, :link)
  end

end
