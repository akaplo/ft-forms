class Field < ActiveRecord::Base
  belongs_to :form
  belongs_to :form_draft

  DATA_TYPES = %w(date date/time explanation heading long-text
                  number options text time yes/no)
  serialize :options, Array

  validate :belongs_to_form_or_form_draft?
  validates :data_type,
            inclusion: { in: DATA_TYPES }
  validates :number,
            :prompt,
            presence: true
  validates :number, uniqueness: { scope: :form }
  validates :options,
            presence: true,
            if: -> { data_type == 'options' }
  validates :required,
            inclusion: { in: [true, false],
                         message: 'must be true or false' }

  default_scope { order :number }

  def date?
    data_type == 'date'
  end

  def explanation?
    data_type == 'explanation'
  end

  def heading?
    data_type == 'heading'
  end

  private

  # must have form or form draft. cannot have both
  def belongs_to_form_or_form_draft?
    return if form.present? ^ form_draft.present?
    errors.add :base,
               'You must specify either a form or form_draft, but not both'
  end
end
