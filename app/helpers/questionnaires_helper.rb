module QuestionnairesHelper

  def select_for_score(field, selected)
    select_tag field, options_for_select(Questionnaire.passing_scores.map { |k, v| ["#{v} - #{k.titleize}", v] }, selected: selected), include_blank: "Don't Assign Score"
  end

end
