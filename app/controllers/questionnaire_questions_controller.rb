class QuestionnaireQuestionsController < ApplicationController
  before_action :find_questionnaire
  before_action :find_question, only: [:edit, :update, :destroy, :move_up, :move_down]
  before_action :only_employer

  before_action :correct_questionnaire, only: [:edit, :update, :destroy, :move_up, :move_down]
  before_action :correct_employer, only: [:edit, :update, :destroy, :move_up, :move_down]

  layout 'my_account'

  def index
    @questions = @questionnaire.questions
  end

  def new
    @question = QuestionnaireQuestion.new
  end

  def create
    @question = @questionnaire.questions.new(permit_params)

    if @question.save
      flash[:success] = 'Question created'
      redirect_to questionnaire_questions_path(@questionnaire)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(permit_params)
      flash[:success] = 'Question updated'
      redirect_to questionnaire_questions_path(@questionnaire)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question deleted'
    redirect_to questionnaire_questions_path(@questionnaire)
  end

  def move_up
    @question.move_higher
    redirect_to questionnaire_questions_path(@questionnaire)
  end

  def move_down
    @question.move_lower
    redirect_to questionnaire_questions_path(@questionnaire)
  end

  private

    def find_questionnaire
      @questionnaire = Questionnaire.find(params[:questionnaire_id])
    end

    def find_question
      @question = QuestionnaireQuestion.find(params[:id])
    end

    def correct_questionnaire
      deny_access unless @question.questionnaire == @questionnaire
    end

    def correct_employer
      deny_access unless @questionnaire.employer == current_user
    end

    def build_answers
      answer_type = params.require(:questionnaire_question)[:answer_type]
      if answer_type == 'yes_no'
        { yes: params[:yes_score], no: params[:no_score] }
      elsif answer_type == 'multiple' || answer_type == 'single'
        answers = []
        params[:answers].each_with_index do |answer, i|
          unless answer.empty?
            answers << { answer: answer, score: params[:answer_scores][i] }
          end
        end
        answers unless answers.empty?
      end
    end

    def permit_params
      permitted_params = params.require(:questionnaire_question).permit(QuestionnaireQuestion.strong_params)
      permitted_params[:answers] = build_answers
      permitted_params
    end

end
