class Transaction < ActiveRecord::Base
  enum transaction_type: [ :income, :outcome ]

  belongs_to :user

  before_save :capitalize_description

  validates :user, :description, :amount, :balance, :transaction_type, presence: true

  private

    def capitalize_description
      description[0] = description[0].upcase
    end

end
