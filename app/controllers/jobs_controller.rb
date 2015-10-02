class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
    #  if params[:search]
      #   @colleges = College.search(params[:search])
      # else
      #   @colleges = College.all
      # end

       @filterrific = initialize_filterrific(
        Job,
        params[:filterrific],
        select_options: {
         
          company_name: Job.options_for_select("company_name"),
          job_title: Job.options_for_select("job_title"),
          location: Job.options_for_select("location"),
        }
        # persistence_id: 'shared_key',
        # default_filter_params: {},
        # available_filters: [],
      ) or return

      # Get an ActiveRecord::Relation for all colleges that match the filter settings.
      # You can paginate with will_paginate or kaminari.
      # NOTE: filterrific_find returns an ActiveRecord Relation that can be
      # chained with other scopes to further narrow down the scope of the list,
      # e.g., to apply permissions or to hard coded exclude certain types of records.
      @jobs = @filterrific.find.page(params[:page])

      # Respond to html for initial page load and to js for AJAX filter updates.
      respond_to do |format|
        format.html
        format.js
      end

    #    # Recover from invalid param sets, e.g., when a filter refers to the
    #   # database id of a record that doesn’t exist any more.
    #   # In this case we reset filterrific and discard all filter params.
    #   rescue ActiveRecord::RecordNotFound => e do
    #     # There is an issue with the persisted param_set. Reset it.
    #     puts "Had to reset filterrific params: #{ e.message }"
    #     redirect_to(reset_filterrific_url(format: :html)) and return
    #   end
    # end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:company_name, :jobtitle, :description, :location)
    end
end
