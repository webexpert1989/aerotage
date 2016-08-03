class QuestionnairesController < ApplicationController
  before_action :sync_optional_fields, only: [:create, :update]
  before_action :find_questionnaire, only: [:edit, :update, :destroy]
  before_action :only_employer

  before_action :correct_employer, only: [:edit, :update, :destroy]

  layout 'my_account'

  def index
    @questionnaires = current_user.questionnaires
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
    @questionnaire = Questionnaire.new(permit_params)
    @questionnaire.employer = current_user

    if @questionnaire.save
      flash[:success] = "'#{@questionnaire.name}' screening questionnaire created. Please add questions to it"
      redirect_to questionnaire_questions_path(@questionnaire)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @questionnaire.update_attributes(permit_params)
      flash[:success] = "'#{@questionnaire.name}' screening questionnaire updated"
      redirect_to questionnaires_path
    else
      render :edit
    end
  end

  def destroy
    @questionnaire.destroy
    flash[:success] = "'#{@questionnaire.name}' screening questionnaire deleted"
    redirect_to questionnaires_path
  end

  private

    def find_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    def correct_employer
      deny_access unless @questionnaire.employer == current_user
    end

    def sync_optional_fields
      params[:questionnaire][:more_email] = '' unless params[:more_email_present].present?
      params[:questionnaire][:less_email] = '' unless params[:less_email_present].present?
    end

    def permit_params
      params.require(:questionnaire).permit(Questionnaire.strong_params)
    end

end
