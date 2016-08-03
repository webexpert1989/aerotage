class ApplicationsController < ApplicationController
  include ApplicationsHelper

  before_action :logged_in_user
  before_action :only_job_seeker, only: [:new, :create]
  before_action :find_application, only: [:show, :change_status, :new_message, :destroy]
  before_action :find_job, only: [:new, :create]
  before_action :check_already_applied, only: [:new, :create]
  before_action :correct_job_seeker, only: [:destroy]
  before_action :correct_employer, only: [:change_status]
  before_action :correct_user, only: [:new_message]

  layout 'my_account', except: [:new, :create]

  def show
    @application.make_messages_read(current_user.to_s)
    render 'show_' + current_user.class.name.underscore
  end

  def new
    @application = @job.applications.new
  end

  def create
    @application = @job.applications.new(permit_params)

    answers = []
    questionnaire_errors = []
    answers_count = 0
    total_score = 0

    if @job.questionnaire.present?
      @job.questionnaire.questions.each_with_index do |question, index|
        if question.text?
          answer = params["question_#{index}"]
          if question.required? && answer.empty?
            questionnaire_errors << "Please answer question #{index + 1}"
          else
            answers << { question: question.content, answer: answer }
          end
        elsif question.yes_no?
          answer = params["question_#{index}"]
          if question.required? && answer.nil?
            questionnaire_errors << "Please answer question #{index + 1}"
          else
            answers << { question: question.content, answer: answer }
            unless answer.nil?
              score = answer == 'Yes' ? question.answers['yes'] : question.answers['no']
              unless score.empty?
                answers_count += 1
                total_score += score.to_i
              end
            end
          end
        elsif question.multiple?
          answer = params["question_#{index}"]
          if question.required? && answer.nil?
            questionnaire_errors << "Please answer question #{index + 1}"
          else
            question_answers = []
            question.answers.each_with_index do |ans, ind|
              if answer.include?(ind.to_s)
                question_answers << ans['answer']
                answers_count += 1
                total_score += ans['score'].to_i
              end
            end
            answers << { question: question.content, answer: question_answers.join(', ') }
          end
        elsif question.single?
          answer = params["question_#{index}"]
          if question.required? && answer.nil?
            questionnaire_errors << "Please answer question #{index + 1}"
          elsif !answer.nil?
            question.answers.each_with_index do |ans, ind|
              if answer.include?(ind.to_s)
                answers << { question: question.content, answer: ans['answer'] }
                answers_count += 1
                total_score += ans['score'].to_i
              end
            end
          end
        end
      end

      @application.questionnaire = { passing_score: Questionnaire.passing_scores[@job.questionnaire.passing_score], score: total_score.to_f / answers_count, answers: answers }
    end

    @application.valid?
    if questionnaire_errors.empty? && @application.save
      @application.rejected! if @job.questionnaire.present? && @application.questionnaire['score'] < @application.questionnaire['passing_score']
      flash[:success] = 'You have successfully applied to this job'
      UserMailer.new_application(@application).deliver
      redirect_to job_path(@job)
    else
      questionnaire_errors.each { |error| @application.errors[:base] << error }
      render :new
    end
  end

  def index
    q = params[:q]
    q = q || { status_in: [0, 1, 2, 3, 4] } if current_user.employer?
    @search = current_user.applications.ransack(q)
    @applications = @search.result
    render 'index_' + current_user.class.name.underscore
  end

  def change_status
    @application.update_attribute(:status, params[:status])
    render nothing: true
  end

  def new_message
    message = params[:message]
    if message.empty?
      flash[:danger] = 'Message cannot be empty'
    else
      message = @application.messages.create(content: message, sender: current_user.to_s)
      UserMailer.new_message(message).deliver
    end
    redirect_to @application
  end

  def destroy
    @application.destroy
    flash[:success] = 'Your application was successfully cancelled and deleted'
    redirect_to applications_path
  end

  private

    def find_application
      @application = Application.find(params[:id])
    end

    def find_job
      @job = Job.friendly.find(params[:job_id])
    end

    def correct_employer
      deny_access unless @application.employer == current_user
    end

    def correct_job_seeker
      deny_access unless @application.job_seeker == current_user
    end

    def correct_user
      if current_user.employer?
        deny_access unless @application.employer == current_user
      else
        deny_access unless @application.job_seeker == current_user && @application.can_reply?
      end
    end

    def check_already_applied
      deny_access if already_applied?(@job)
    end

    def permit_params
      params.require(:application).permit(Application.strong_params)
    end

end
